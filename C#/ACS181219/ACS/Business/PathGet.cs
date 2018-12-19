using System;
using System.Collections.Generic;
using System.Linq;

namespace ACS
{
    public class PathGet
    {
        /// <summary>
        /// 生成路径
        /// </summary>
        /// <returns>路径集合</returns>
        public static List<PathPoint> GetPath(Agv agv)
        {
            STask sTask = agv.sTaskList[0];
            Point beginPoint = App.PointList.FirstOrDefault(a => a.barCode == agv.barcode);
            Point endPoint = sTask.endPoint;
            STaskType sTaskType = sTask.sTaskType;
            agv.RePathLevel = 0;
            switch (sTask.sTaskType)
            {
                case STaskType.D1:
                    if (beginPoint == endPoint)
                        return new List<PathPoint>() {GetObject.GetPathPoint(endPoint) };
                    
                    AStar aStart = new AStar();
                    List<Point> listApoint = GetCanUseApoint(agv);
                    ClearParentPoint();
                    Point Parent = aStart.PathGet(listApoint, beginPoint, endPoint, agv);
                    if (Parent == null)
                    {
                        sTask.state = TaskState.PathFail;
                        return null;
                    }

                    List<PathPoint> listPathPoint = GetPathList(Parent);
                    OriLock(listPathPoint, agv);

                    return listPathPoint;
                case STaskType.D2:
                case STaskType.D3:
                case STaskType.D4:
                case STaskType.D5:
                case STaskType.D6:
                case STaskType.D7:
                case STaskType.D8:
                    return new List<PathPoint>() { GetObject.GetPathPoint(endPoint) };
                case STaskType.D9:
                    //左弧右弧进
                    break;
                case STaskType.D10:
                case STaskType.D11:
                    //左弧右弧出
                    break;
                case STaskType.D12:
                    //左弧右弧出
                    break;
                default:
                    throw new Exception("无此任务类型:" + sTask.sTaskType);
            }

            sTask.state = TaskState.PathFail;
            return null;
        }

        static void ClearParentPoint()
        {
            foreach (Point point in App.PointList)
            {
                if (point.ParentPoint != null)
                    point.ParentPoint = null;
            }
        }

        /// <summary>
        ///获取可用的路径点
        /// </summary>
        static List<Point> GetCanUseApoint(Agv agv)
        {
            STask sTask = agv.sTaskList[0];
            Point beginPoint = sTask.beginPoint;
            Point endPoint = sTask.endPoint;

            //获取可用点
            List<Point> listApoint = new List<Point>();
            foreach (Point point in App.PointList)
            {
                if (point != beginPoint && point != endPoint)
                {
                    //起点周围点被锁定，且车的位置也在此点，则不建路径
                    //解决异常重建时，路径依旧堵死的问题
                    if (point == beginPoint.xNegPoint
                        && point.lockedAgv != null
                        && point.lockedAgv.barcode == point.barCode)
                        continue;
                    if (point == beginPoint.xPosPoint
                        && point.lockedAgv != null
                        && point.lockedAgv.barcode == point.barCode)
                        continue;
                    if (point == beginPoint.yNegPoint
                        && point.lockedAgv != null
                        && point.lockedAgv.barcode == point.barCode)
                        continue;
                    if (point == beginPoint.yPosPoint
                        && point.lockedAgv != null
                        && point.lockedAgv.barcode == point.barCode)
                        continue;

                    //如果是货架点
                    if (point.pointType == PointType.D6)
                    {
                        //如果是顶升，则禁止使用货架点
                        if (agv.height == HeightEnum.High)
                            continue;                      
                    }
                    ////如果是其他任务终点，则禁止通过(有问题)
                    //bool isTask = App.AgvList.Exists(a =>
                    //                    a.sTaskList.Exists(b =>
                    //                    b.endPoint == point ));
                    //if (isTask)
                    //    continue;

                    //以下点类型不使用
                    if (point.pointType == PointType.D10                
                    || point.pointType == PointType.D4
                        || point.pointType == PointType.D3)
                        continue;

                    //被占用，不使用
                    if (point.isOccupy)
                        continue;
                    
                    //不包含agv的区域则不选择
                    if (!point.areaNo.Contains(agv.areaNo))
                        continue;
                }
                
                listApoint.Add(point);
            }

            return listApoint;
        }

        static List<PathPoint> GetPathList(Point Parent)
        {
            List<PathPoint> listPathPoint = new List<PathPoint>();

            while (Parent != null)
            {
                listPathPoint.Add(GetObject.GetPathPoint(Parent));
                Parent = Parent.ParentPoint;
            }
            
            listPathPoint.Reverse();
            for (int i = 0; i < listPathPoint.Count; i++)
            {
                listPathPoint[i].serialNo = i + 1;
            }

            return listPathPoint;
        }

        /// <summary>
        /// 锁定路径方向
        /// </summary>
        /// <param name="Path"></param>
        public static void OriLock(List<PathPoint> Path, Agv agv)
        {
            //终点不比较
            for (int i = 0; i < Path.Count - 1; i++)
            {
                Point point = Path[i].point;
                Point nextPoint = Path[i + 1].point;
                if (point == nextPoint)
                    continue;

                AStar aStart = new AStar();
                int direction = aStart.GetDircition(nextPoint, point);

                TmpDirection td = new TmpDirection();
                td.direction = direction;
                td.agvNo = agv.agvNo;
                point.listTmpDirection.Add(td);
            }
        }
    }
}
