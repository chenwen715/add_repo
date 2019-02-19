using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace ACS
{
    public class MsgManage
    {
        /// <summary>
        /// 指令解析
        /// </summary>
        /// <param name="socketOpt">自定义Socket对象</param>
        public static void DataTranslate(SocketOpt socketOpt)
        {
            string errMsg = "";

            byte[] DataRecv = socketOpt.recData;
            string AgvNo = Encoding.ASCII.GetString(DataRecv, 3, 10).Replace("\0", "");
            //记录回给小车的信息
            //App.ExFile.MessageLog("Get" + AgvNo, BitConverter.ToString(DataRecv, 0, 31));
            App.ExFile.MessageLog("Get" + AgvNo, BitConverter.ToString(DataRecv));

            AgvMsg agvMsg = new AgvMsg();
            int DataLength = DataRecv[2];
            agvMsg.AgvNo = AgvNo;
            socketOpt.agv = App.AgvList.FirstOrDefault(a => a.agvNo == agvMsg.AgvNo);
            if (socketOpt.agv != null)
            {
                agvMsg.Barcode = BitConverter.ToUInt32(DataRecv, 13).ToString();
                //agvMsg.Barcode = BitConverter.ToUInt32(DataRecv, 13).ToString().PadLeft(4, '0');
                agvMsg.Voltage = BitConverter.ToInt16(DataRecv, 17) / 100;
                agvMsg.State = DataRecv[19];
                agvMsg.Height = (HeightEnum)DataRecv[20];
                agvMsg.ErrCode1 = DataRecv[21];
                agvMsg.ErrCode2 = DataRecv[22];
                agvMsg.ErrCode3 = DataRecv[23];

                string sid = BitConverter.ToUInt32(DataRecv, 26).ToString();
                if (string.IsNullOrEmpty(sid))
                    agvMsg.SID = 0;
                else
                    agvMsg.SID = int.Parse(sid);

                agvMsg.sTaskStatus = DataRecv[30];

                int CrcR = DataRecv[31];
                int CrcC = Commond.CRC(DataRecv, DataLength + 14);

                if (CrcC == CrcR)
                {
                    //计算时间
                    //TimeSpan ts1 = new TimeSpan(DateTime.Now.Ticks);
                    UpdateAgvShelfPoint(agvMsg, socketOpt.agv);
                    //TimeSpan ts2 = new TimeSpan(DateTime.Now.Ticks);
                    //TimeSpan ts3 = ts2.Subtract(ts1).Duration();
                    //socketOpt.dealTime = ts3.Milliseconds;

                    UpdataPointOri(agvMsg, socketOpt.agv);

                    if (IsAgvWork(agvMsg, socketOpt, ref errMsg))
                        AgvDoTask(agvMsg, socketOpt);
                }
                else
                {
                    errMsg = "AGV数据校验失败！";
                }
            }
            else
            {
                errMsg = "找不到此小车对象：" + AgvNo;
            }

            if (!string.IsNullOrEmpty(errMsg))
            {
                App.ExFile.MessageError("Error" + agvMsg.AgvNo, errMsg);
            }

            if (Commond.IsTest)
            {
                if (socketOpt.SendData == null)
                {
                    socketOpt.SendData = SendData.GetRepeatData(AgvNo);
                }
            }

            
            ManageTcp.Send(socketOpt);
        }

        /// <summary>
        /// 接收小车心跳下发新动作
        /// </summary>
        static void AgvDoTask(AgvMsg agvMsg, SocketOpt socketOpt)
        {
            Agv agv = socketOpt.agv;
            STask sTask = agv.sTaskList.FirstOrDefault();
            PathPoint pPoint = sTask.pathList.FirstOrDefault(a => a.point.barCode == agvMsg.Barcode);

            //任务完成
            if (agvMsg.SID != 0 && agvMsg.Barcode == sTask.endPoint.barCode && agvMsg.sTaskStatus==1)
            {
                Task.FinishTask(agv, sTask);
                socketOpt.SendData = SendData.GetFinishData(agv.agvNo);
            }
            else
            {
                //如果站台有车，则不会去执行任务
                if (sTask.endPoint.pointType == PointType.D4)
                    if (sTask.endPoint.lockedAgv != null)
                        if (sTask.endPoint.lockedAgv != agv)
                            return;

                List<Motion> listMotion = GetNextPoint.Motions(sTask, pPoint, agv);
                if (listMotion.Count == 0 && sTask.pathList.Count != 0)
                    throw new Exception(agv.agvNo+"找到0条路径点");
                else if (listMotion.Count < 2 && sTask.pathList.Count > 1)
                {
                    if (Commond.IsTest)
                    {
                        socketOpt.SendData = SendData.GetRepeatData(agv.agvNo);
                    }
                }
                socketOpt.SendData = SendData.GetNewActionData(sTask.sID, listMotion);

                //除发送给AGV的点外，其它点全部解锁方向
                NoLock(agv, listMotion);
            }
        }

        /// <summary>
        /// 检查小车状态是否正确
        /// </summary>
        static bool IsAgvWork(AgvMsg agvMsg, SocketOpt socketOpt, ref string errMsg)
        {
            Agv agv = socketOpt.agv;

            //小车处于手动状态或是无码状态，不发新动作
            if (agv.state == AgvState.D20 || agv.state == AgvState.D21 || agv.state == AgvState.D10 || agv.state == AgvState.D12)
                return false;

            if (agv.errorMsg != 0)
                return false;

            //小车处于忙碌状态但是任务状态为未完成，不发新动作
            if (agv.state == AgvState.D13 && agvMsg.sTaskStatus == 0)
            {
                errMsg += "小车有任务且未完成；" + agv.agvNo;
                return false;
            }

            if (agv.sTaskList.Count == 0)
                return false;
            STask sTask = agv.sTaskList[0];
            if (sTask.state != TaskState.PathSuccess)
                return false;

            if (sTask.sID != agvMsg.SID && agvMsg.SID != 0)
            {
                errMsg += "当前小车子任务不匹配；" + agv.agvNo;
                socketOpt.SendData = SendData.GetFinishData(agv.agvNo);
                return false;
            }

            //顶升、旋转、充电等，小车位置必须在终点位置
            if (sTask.sTaskType != STaskType.D1)
                if (agv.barcode != sTask.endPoint.barCode)
                {
                    errMsg += "做顶升任务或是旋转时小车与终点不在同一地点；";
                    return false;
                }
            
            //当前点不在路径中
            PathPoint pPoint = sTask.pathList.FirstOrDefault(a => a.point.barCode == agvMsg.Barcode);
            if (pPoint == null)
            {
                if (sTask.sTaskType == STaskType.D1)
                    Task.ResetPath(agv);
                errMsg += "当前点不在路径中（行走任务重建路径中。。。。。）" + agv.agvNo;
                return false;
            }

            if (sTask.sTaskType == STaskType.D1)
            {
                if (sTask.HaveShelf)
                {
                    if (agv.height != HeightEnum.High)
                    {
                        errMsg += "行走任务需载货架，小车状态必须是高位；" + agv.agvNo;
                        return false;
                    }
                    Shelf shelf = App.ShelfList.FirstOrDefault(a => a.currentBarcode == agv.barcode);
                    if (shelf == null)
                    {
                        errMsg += "小车与任务中的货架不在同一个位置；" + agv.agvNo;
                        return false;
                    }
                }
                else
                {
                    if (agv.height != HeightEnum.Low)
                    {
                        errMsg += "行走任务无货架，小车状态必须是低位" + agv.agvNo;
                        return false;
                    }
                }
            }
            
            return true;
        }

        static void NoLock(Agv agv, List<Motion> listMotion)
        {
            //除要发送给AGV的点外，其他被此agv占用的点全部解除
            List<Point> listPoint = App.PointList.Where(a => a.lockedAgv == agv).ToList();
            foreach (Point point in listPoint)
            {
                if (!listMotion.Exists(a => a.barcode == point.barCode))
                    point.lockedAgv = null;
            }
        }

        /// <summary>
        /// 更新小车货架信息
        /// </summary>
        static void UpdateAgvShelfPoint(AgvMsg agvMsg, Agv agv)
        {
            string oldBarcode = agv.barcode;
            string newBarcode = agvMsg.Barcode;
            //刚开机，没扫到码，给的是0
            if (newBarcode == "0")
                agvMsg.Barcode = newBarcode = oldBarcode;

            //占用当前点，解除旧点占用
            Point oldPoint = App.PointList.FirstOrDefault(a => a.barCode == oldBarcode);
            Point currentPoint = App.PointList.FirstOrDefault(a => a.barCode == newBarcode);
            if (currentPoint == null)
                throw new Exception(agv.agvNo + "发送的点不在地图中！" + newBarcode);

            UpdatePoint(oldPoint, currentPoint, agv);

            ////如果AGV的位置状态不变，不更新Agv状态
            if (newBarcode == oldBarcode
                && agv.height == agvMsg.Height
                && agv.currentCharge == agvMsg.Voltage
                && agv.state == (AgvState)agvMsg.State
                && agv.errorMsg == agvMsg.ErrCode1 + agvMsg.ErrCode2 + agvMsg.ErrCode3)
                return;

            //更新数据库中小车的状态
            int error = agvMsg.ErrCode1 * 10000 + agvMsg.ErrCode2 * 100 + agvMsg.ErrCode3;
            string sql = string.Format(@"UPDATE dbo.T_Base_AGV SET Barcode = '{0}',ErrorMsg = '{1}',
                Height = '{2}',CurrentCharge = '{3}',UpdateTime = GETDATE(),State = '{4}',Direction={6} WHERE AgvNo = '{5}';",
                newBarcode, error, (int)agvMsg.Height, agvMsg.Voltage, agvMsg.State, agvMsg.AgvNo, currentPoint.OriAgv);

            //配送与仓库不同，此判断条件需要考量。   低位/中位/高位的问题
            if (agvMsg.Height == HeightEnum.High)
            {
                Shelf shelf = App.ShelfList.FirstOrDefault(a => a.currentBarcode == oldBarcode);
                if (shelf != null)
                {
                    //货架的当前点要变更为现在的点
                    sql += string.Format(@"UPDATE T_Base_Shelf SET CurrentBarcode = '{0}' 
                                            WHERE CurrentBarcode = '{1}';", newBarcode, oldBarcode);


                    shelf.currentBarcode = newBarcode;
                    App.sharp.ShelfChange(shelf, currentPoint);
                }
                else
                    throw new Exception("小车顶升是高位，但是无货架点！");
            }      
            DbHelperSQL.ExecuteSql(sql);

            agv.angle = currentPoint.OriAgv;
            agv.barcode = newBarcode;
            agv.height = agvMsg.Height;
            agv.currentCharge = agvMsg.Voltage;
            agv.state = (AgvState)agvMsg.State;
            agv.errorMsg = agvMsg.ErrCode1 + agvMsg.ErrCode2 + agvMsg.ErrCode3;
            App.sharp.AgvShelfStatusChange(agv);
            App.sharp.AgvChange(agv, currentPoint);  
        }

        /// <summary>
        /// 更新点信息
        /// </summary>
        static void UpdatePoint(Point oldPoint, Point currentPoint, Agv agv)
        {
            //如果当前AGV无任务
            if (agv.sTaskList.Count == 0)
            {
                //如果当前点未被自身占用则报错
                if (!currentPoint.isOccupy ||(currentPoint.isOccupy&&currentPoint.occupyAgvNo!=agv.agvNo))
                {
                    string sql2 = string.Format("Update dbo.T_Base_Point set IsOccupy = 1,OccupyAgvNo = '{0}',OriAgv={2} where barcode = '{1}'", agv.agvNo, currentPoint.barCode,currentPoint.OriAgv);
                    DbHelperSQL.ExecuteSql(sql2);

                    currentPoint.isOccupy = true;
                    currentPoint.occupyAgvNo = agv.agvNo;
                }
            }

            if (oldPoint != null && oldPoint != currentPoint)
            {
                oldPoint.lockedAgv = null;
                currentPoint.lockedAgv = agv;
            }
        }

        /// <summary>
        /// 更新点方向锁信息
        /// </summary>
        static void UpdataPointOri(AgvMsg agvMsg, Agv agv)
        {
            //找到小车当前的任务
            STask sTask = agv.sTaskList.FirstOrDefault(a => a.sID == agvMsg.SID);
            if (sTask == null)
                return;
            
            PathPoint pathCurrent = sTask.pathList.FirstOrDefault(a => a.point.barCode == agv.barcode);
            if (pathCurrent == null)
                if (sTask.state==TaskState.PathSuccess)
                throw new Exception("AGV当前点不在路径中！" + agv.agvNo);

            //查找所有被当前小车锁定的点
            List<Point> listPoint = App.PointList.Where(a => a.listTmpDirection.Exists(b => b.agvNo == agv.agvNo)).ToList();

            foreach (Point point in listPoint)
            {
                //如果当前点不在小车的路径中
                //如果当前点是小车所在的点,当前点不能解除方向锁。解除会导致对面的车冲突
                //则清理当前点的路径锁
                
                if (!sTask.pathList.Exists(a => a.point == point))
                    point.listTmpDirection.RemoveAll(a => a.agvNo == agv.agvNo);
            }
        }
    }
}
