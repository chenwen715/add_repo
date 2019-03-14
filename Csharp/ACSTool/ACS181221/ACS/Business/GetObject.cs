using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace ACS
{
    /// <summary>
    /// 获取对象
    /// </summary>
    public class GetObject
    {
        public static Shelf GetShelf(DataRow dr)
        {
            Shelf s = new Shelf();
            s.areaNo = dr["areaNo"].ToString();
            s.barcode = dr["barcode"].ToString();
            s.currentBarcode = dr["currentBarcode"].ToString();
            s.isEnable = bool.Parse(dr["isEnable"].ToString());
            s.isLocked = bool.Parse(dr["isLocked"].ToString());
            s.shelfDirection = dr["shelfDirection"].ToString();
            s.shelfNo = dr["shelfNo"].ToString();

            return s;
        }

        public static Agv GetAgv(DataRow dr)
        {
            Agv a = new Agv();
            a.agvNo = dr["agvNo"].ToString();
            a.barcode = dr["barcode"].ToString();
            a.currentCharge = float.Parse(dr["currentCharge"].ToString());
            a.errorMsg = int.Parse(dr["errorMsg"].ToString());
            a.height = (HeightEnum)int.Parse(dr["height"].ToString());
            a.isEnable = bool.Parse(dr["isEnable"].ToString());
            a.sTaskList = new List<STask>();
            a.state = (AgvState)int.Parse(dr["state"].ToString());
            a.areaNo = dr["areaNo"].ToString();
            a.angle = int.Parse(dr["direction"].ToString());

            return a;
        }

        public static Point GetPoint(DataRow dr)
        {
            Point p = new Point();
            p.isXPos = bool.Parse(dr["isXPos"].ToString());
            p.isYPos = bool.Parse(dr["isYPos"].ToString());
            p.isYNeg = bool.Parse(dr["isYNeg"].ToString());
            p.isXNeg = bool.Parse(dr["isXNeg"].ToString());
            p.listTmpDirection = new List<TmpDirection>();
            p.areaNo = dr["AreaNo"].ToString();
            p.barCode = dr["Barcode"].ToString();
            p.isEnable = bool.Parse(dr["isEnable"].ToString());
            p.RotateAgvNo =dr["RotateAgvNo"].ToString();
            p.isOccupy = bool.Parse(dr["isOccupy"].ToString());
            p.lockedAgv = null;
            p.occupyAgvNo = dr["occupyAgvNo"].ToString();
            p.pointType = (PointType)int.Parse(dr["PointType"].ToString());
            p.x = int.Parse(dr["X"].ToString());
            p.y = int.Parse(dr["Y"].ToString());
            p.xLength = int.Parse(dr["xLength"].ToString());
            p.yLength = int.Parse(dr["yLength"].ToString());
            p.OriAgv = int.Parse(dr["OriAgv"].ToString());
            p.OriDial = int.Parse(dr["OriDial"].ToString());
            p.AntiCollision = int.Parse(dr["AntiCollision"].ToString());

            return p;
        }

        public static RotatePoint GetRotatePoint(DataRow dr)
        {
            RotatePoint p = new RotatePoint();
            string aroundBarcode = dr["aroundBarcode"].ToString();
            string rotateBarcode = dr["rotateBarcode"].ToString();
            p.aroundPoint = App.PointList.FirstOrDefault(a => a.barCode == aroundBarcode);
            p.rotatePoint = App.PointList.FirstOrDefault(a => a.barCode == rotateBarcode);

            return p;
        }

        public static KeyPoint GetKeyPoint(DataRow dr)
        {
            KeyPoint p = new KeyPoint();
            string aroundBarcode = dr["keyBarcode"].ToString();
            string rotateBarcode = dr["keyArea"].ToString();
            p.keyPoint = App.PointList.FirstOrDefault(a => a.barCode == aroundBarcode);
            p.keyArea = rotateBarcode;

            return p;
        }

        public static STask GetSTask(DataRow dr)
        {
            STask sTask = new STask();
            sTask.serialNo = int.Parse(dr["SerialNo"].ToString()); ;
            sTask.sID = int.Parse(dr["SID"].ToString());
            sTask.taskNo = dr["TaskNo"].ToString();
            sTask.HaveShelf = bool.Parse(dr["HaveShelf"].ToString());
            sTask.sTaskType = (STaskType)int.Parse(dr["ItemName"].ToString());
            sTask.agv = App.AgvList.FirstOrDefault(a => a.agvNo == dr["AgvNo"].ToString());
            sTask.endPoint = App.PointList.FirstOrDefault(a => a.barCode == dr["EndPoint"].ToString());
            sTask.dialDirection = int.Parse(dr["DialDirection"].ToString());
            sTask.agvDirection = int.Parse(dr["AgvDirection"].ToString());
            sTask.state = (TaskState)(int.Parse(dr["State"].ToString()));
            sTask.pathList = new List<PathPoint>();
            sTask.agv.sTaskList.Add(sTask);
            return sTask;
        }

        public static Motion GetMotion(STask st, PathPoint ppCurrent)
        {
            Motion motion = new Motion();
            motion.sTaskType = st.sTaskType;
           
            //如果是子任务的终点,给出车头方向和转盘方向
            if (ppCurrent.serialNo == st.pathList[st.pathList.Count - 1].serialNo)
            {
                motion.OriAgv = st.agvDirection;
                motion.OriDial = st.dialDirection;
            }
                     
            motion.barcode = ppCurrent.point.barCode;
            motion.x = ppCurrent.point.x;
            motion.y = ppCurrent.point.y;
            motion.xLength = ppCurrent.point.xLength;
            motion.yLength = ppCurrent.point.xLength;
            motion.pointType = (int)ppCurrent.point.pointType;
            motion.AntiCollision = ppCurrent.point.AntiCollision;
          
            return motion;
        }

        public static Motion GetMotion(STask st, PathPoint ppCurrent, List<PathPoint> listPathPoint)
        {
            Motion motion = new Motion();
            motion.sTaskType = st.sTaskType;

            //如果是子任务的终点,给出车头方向和转盘方向
            //if (ppCurrent.serialNo == st.pathList[st.pathList.Count - 1].serialNo)
            //{
            //    motion.OriAgv = st.agvDirection;
            //    motion.OriDial = st.dialDirection;
            //}
            if (listPathPoint.IndexOf(ppCurrent) > 0)
            {
                PathPoint lastp = listPathPoint[listPathPoint.IndexOf(ppCurrent) - 1];
                if (lastp.point.x == ppCurrent.point.x && lastp.point.y + 1 == ppCurrent.point.y)
                {
                    motion.OriAgv = 4;
                    ppCurrent.point.OriAgv = 4;
                }
                else if (lastp.point.x == ppCurrent.point.x && lastp.point.y - 1 == ppCurrent.point.y)
                {
                    motion.OriAgv = 2;
                    ppCurrent.point.OriAgv = 2;
                }
                else if (lastp.point.y == ppCurrent.point.y && lastp.point.x - 1 == ppCurrent.point.x)
                {
                    motion.OriAgv = 3;
                    ppCurrent.point.OriAgv = 3;
                }
                else
                {
                    motion.OriAgv = 1;
                    ppCurrent.point.OriAgv = 1;
                }               
            }
            motion.barcode = ppCurrent.point.barCode;
            motion.x = ppCurrent.point.x;
            motion.y = ppCurrent.point.y;
            motion.xLength = ppCurrent.point.xLength;
            motion.yLength = ppCurrent.point.xLength;
            motion.pointType = (int)ppCurrent.point.pointType;
            motion.AntiCollision = ppCurrent.point.AntiCollision;

            return motion;
        }

        public static PathPoint GetPathPoint(Point point)
        {
            PathPoint pp = new PathPoint();
            pp.point = point;
            return pp;
        }
    }
}
