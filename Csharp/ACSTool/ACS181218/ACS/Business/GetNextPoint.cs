using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ACS
{
    public class GetNextPoint
    {
        /// <summary>
        /// 获取行走后面的点
        /// </summary>
        public static List<Motion> Motions(STask sTask, PathPoint pathPoint, Agv agv)
        {
            List<Motion> listMotion = new List<Motion>();
            List<PathPoint> listPathPoint = sTask.pathList;

            //移除当前点之前的路径点
            sTask.pathList.RemoveAll(a => a.serialNo < pathPoint.serialNo);
          
            int i = 0;
            foreach (PathPoint pp in listPathPoint)
            {
                if (sTask.sTaskType == STaskType.D8)
                {  //检测是否可以下发旋转任务：周围必须没有车
                    //锁住周围点
                    string mess = "";
                    List<RotatePoint> rp = App.RotatePointList.FindAll(a => a.rotatePoint ==
                        App.PointList.FirstOrDefault(b => b.barCode == agv._barcode));
                    foreach (RotatePoint p in rp)
                    {
                        if (p.aroundPoint.lockedAgv != null && p.aroundPoint.lockedAgv!=agv)
                        {
                            mess = "周围有车！";
                            break;
                        }
                    }

                    if (!string.IsNullOrEmpty(mess)) break;
                    LockRotate(agv,pp.point);
                }
                Point nowPoint = pp.point;
                i++;
                if (i == 5)
                    break;

                if (Commond.IsTest && nowPoint.barCode == "2280")
                {
                    //listMotion.Add(GetObject.GetMotion(sTask, pp));
                    listMotion.Add(GetObject.GetMotion(sTask, pp, listPathPoint));//修改加小车方向
                    continue;
                }
                if (nowPoint.lockedAgv == agv)
                {
                    //listMotion.Add(GetObject.GetMotion(sTask, pp));
                    listMotion.Add(GetObject.GetMotion(sTask, pp, listPathPoint));
                    continue;
                }

                if (nowPoint.lockedAgv != null)
                {
                    //只有在AGV的下一个点才会判断需不需要重建（有可能AGV在运动中）
                    if (listMotion.Count == 1)
                    {
                        Agv nextAgv = nowPoint.lockedAgv;
                        //无任务小车重建
                        //故障车不重建
                        //重建失败车重建
                        if (nextAgv.sTaskList.Count == 0
                            || (nextAgv.sTaskList[0].state == TaskState.PathFail))
                        {
                            Task.ResetPath(agv);
                        }
                    }

                    break;
                }

                bool isLoop = false;
                Loop(nowPoint, new List<Agv>() { agv }, ref isLoop);
                if (isLoop)
                    break;
                
                //顶升小车不走货架所在点
                if (agv.height != HeightEnum.Low)
                {
                    Shelf shelf = App.ShelfList.FirstOrDefault(a => a.currentBarcode == nowPoint.barCode);
                    if (shelf != null)
                        break;
                }


                if (App.KeyPointList.FirstOrDefault(a => a.keyPoint.barCode == agv.barcode) == null && !KeyArea(nowPoint))
                    break;

                //旋转区域被锁，且此车当前不在旋转区域内，跳出
                if (!Ratote(agv, sTask,pp))
                    break;
                //工作位区域被锁，且此车当前不在工作位区域内，跳出
                
                nowPoint.lockedAgv = agv;
                //listMotion.Add(GetObject.GetMotion(sTask, pp));
                listMotion.Add(GetObject.GetMotion(sTask, pp, listPathPoint));
            }
            
            return listMotion;
        }

        /// <summary>
        /// 流量管控区域
        /// </summary>
        /// <param name="nowPoint"></param>
        /// <returns></returns>
        static bool KeyArea(Point nowPoint)
        {
            KeyPoint kp = App.KeyPointList.FirstOrDefault(
                a => a.keyPoint == nowPoint);
            if (kp == null)
                return true;

            List<string> agv = App.AgvList.Select(a => a.barcode).ToList();
            List<string> pointArea = App.KeyPointList.FindAll(a => a.keyArea == kp.keyArea).Select(a => a.keyPoint).Select(a => a.barCode).ToList();
            int agvCount = agv.Intersect(pointArea).ToList().Count;

            if (agvCount <= 7)
                return true;

            return false;
        }

        /// <summary>
        /// 旋转区域逻辑判断
        /// </summary>
        static bool Ratote(Agv agv, STask sTask, PathPoint pp)
        {
            //找出当前点所在的旋转区域的旋转点
          RotatePoint rp = App.RotatePointList.FirstOrDefault(
                a => a.aroundPoint == pp.point || a.rotatePoint == pp.point);
            if (rp == null)
                return true;
          
                Point rotatePoint = rp.rotatePoint;
                //如果此AGV要在此旋转区域旋转
                if (IsRotateAgv(agv, rotatePoint,pp))
                {
                    //如果旋转区域被当前AGV锁定
                    if (rotatePoint.RotateAgvNo == agv.agvNo)
                    {
                        //如果此点是周围点，发送
                        if (pp.point != rotatePoint)
                            return true;

                        //如果旋转区域内的AGV，都不需要经过旋转点，发送
                        if (!IsPassRotateAgv(agv, rotatePoint))
                            return true;

                        return false;
                    }
                    //旋转区域被其他AGV锁定
                    else if (rotatePoint.RotateAgvNo != "")
                        return false;
                    //旋转区域未被锁定
                    else
                    {
                        //如果此点是周围点
                        if (pp.point != rotatePoint)
                        {
                            //锁定旋转点及所有周围点，上传SQL，发送
                            LockRotate(agv, rotatePoint);
                            return true;
                        }
                        
                        //如果旋转区域的AGV都不需要经过旋转点
                        if (!IsPassRotateAgv(agv, rotatePoint))
                        {
                            //锁定旋转点及所有周围点，上传SQL，发送
                            LockRotate(agv, rotatePoint);
                            return true;
                        }

                        return false;
                    }
                }
                else    //不在此区域旋转
                {
                    //如果被锁定且当前AGV没有LOCK到任一区域点，则不发
                    if ( rotatePoint.RotateAgvNo != "" )
                    {
                        if (!App.RotatePointList.Exists(a => a.aroundPoint.lockedAgv == agv || a.rotatePoint.lockedAgv == agv))
                            return false;
                    }
                    return true;
                }
           
           
        }

        static void LockRotate(Agv agv, Point rotatePoint)
        {
            //找到所有旋转点和周围点
            List<RotatePoint> listRotatePoint = App.RotatePointList.FindAll(a => a.rotatePoint == rotatePoint);
            if (rotatePoint.RotateAgvNo != agv.agvNo)
            {
                rotatePoint.RotateAgvNo = agv.agvNo;
                string sql = string.Format("UPDATE dbo.T_Base_Point SET RotateAgvNo = '{0}' WHERE BarCode = '{1}'", agv.agvNo, rotatePoint.barCode);
                DbHelperSQL.ExecuteSql(sql);

                foreach (RotatePoint rp in listRotatePoint)
                {
                    rp.aroundPoint.RotateAgvNo = agv.agvNo;

                    string sql1 = string.Format("UPDATE dbo.T_Base_Point SET RotateAgvNo = '{0}' WHERE BarCode = '{1}'", agv.agvNo, rp.aroundPoint.barCode);
                    DbHelperSQL.ExecuteSql(sql1);
                }
            }
        }

        static bool IsPassRotateAgv(Agv agv, Point rotatePoint)
        {
            //找到所有旋转点和周围点
            List<RotatePoint> listRotatePoint = App.RotatePointList.FindAll(a => a.rotatePoint == rotatePoint);
            foreach (RotatePoint rp in listRotatePoint)
            {
                //获取占用此区域的agv
                Agv otherAgv = rp.aroundPoint.lockedAgv;
                if (otherAgv != null && otherAgv != agv)
                {
                    //如果有任务
                    if (otherAgv.sTaskList.Count > 0)
                    {
                        //如果AGV的任务路过旋转点
                        if (otherAgv.sTaskList[0].pathList.Exists(a => a.point == rotatePoint))
                            return true;
                    }
                }
            }

            return false;
        }

        static bool IsRotateAgv(Agv agv, Point rotatePoint, PathPoint pp)
        {
           
            if (agv.sTaskList.Count < 2)
                return false;

            STask sTask1 = agv.sTaskList[0];
            STask sTask2 = agv.sTaskList[1];
            //第一个任务的终点是旋转点，且第二条任务是旋转任务时
            //且后面的路径点均在旋转区内
            List<RotatePoint> lr = App.RotatePointList.FindAll(a => a.rotatePoint == rotatePoint).ToList();
            foreach (PathPoint p in sTask1.pathList.Where(a=>a.serialNo>pp.serialNo))
            {
               
                if (!lr.Exists(a => a.rotatePoint == p.point || a.rotatePoint == p.point))
                    return false;
            }

            if (sTask1.endPoint == rotatePoint && sTask2.sTaskType == STaskType.D8 )
                return true;

            return false;
        }

        /// <summary>
        /// 当前点被其他车占用时，处理方式（有问题，待修改）
        /// </summary>
        /// <param name="nowPoint"></param>
        /// <param name="agv"></param>
        static void OtherAgvLock(Point nowPoint, Agv agv)
        {

        }

        /// <summary>
        /// 检查是否有回旋死锁
        /// </summary>
        static void Loop(Point nowPoint, List<Agv> listAgv, ref bool isLoop)
        {
            //找最新的AGV
            Agv lastAgv = listAgv.LastOrDefault();
            PathPoint nextPoint = GetNextPathPoint(lastAgv, nowPoint);
            if (nextPoint != null)
            {
                //获取占用此点的AGV
                Agv agv = nextPoint.point.lockedAgv;
                //此点被另外的AGV占用了
                if (agv != null && agv != lastAgv)
                {
                    listAgv.Add(agv);

                    //如果还没找到第四个点，则继续找
                    if (listAgv.Count == 4)
                    {
                        if (listAgv[0].agvNo != listAgv[3].agvNo )
                            isLoop = true;
                        else
                            isLoop = false;

                        return;
                    }

                    Loop(nextPoint.point, listAgv, ref isLoop);
                }
            }
        }

        /// <summary>
        ///获取下面的路径点
        /// <summary>
        static PathPoint GetNextPathPoint(Agv agv, Point p)
        {
            int i = 0;
            if (agv.sTaskList.Count == 0)
                return null;
            foreach (PathPoint pp in agv.sTaskList[0].pathList)
            {
                if (pp.point.barCode == p.barCode)
                {
                    i = 1000;
                    continue;
                }
                i++;
                if (i == 1001)
                    return pp;
            }
            return null;
        }
    }
}
