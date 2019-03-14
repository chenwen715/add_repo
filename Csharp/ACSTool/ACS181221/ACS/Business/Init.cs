﻿using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace ACS
{
    /// <summary>
    /// 系统启动时初始化数据
    /// </summary>
    public class Init
    {
        public static void InitData()
        {
            DownPoint();
            DownRotatePoint();
            DownKeyPoint();
            DownShelf();
            DownAgv();
            DownSTask();
            DownPath();
            
        }

        static void DownPoint()
        {
            string sql = string.Format("SELECT * FROM dbo.T_Base_Point ");
            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Point point = GetObject.GetPoint(dr);
                App.PointList.Add(point);
            }

            foreach (Point p in App.PointList)
            {
                p.xPosPoint = App.PointList.FirstOrDefault(a => a.x == p.x + 1 && a.y == p.y);
                p.xNegPoint = App.PointList.FirstOrDefault(a => a.x == p.x - 1 && a.y == p.y);
                p.yPosPoint = App.PointList.FirstOrDefault(a => a.x == p.x && a.y == p.y + 1);
                p.yNegPoint = App.PointList.FirstOrDefault(a => a.x == p.x && a.y == p.y - 1);
            }
        }

        static void DownRotatePoint()
        {
            string sql = string.Format("SELECT * FROM dbo.T_Base_RotatePoint ");
            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                RotatePoint rotatePoint = GetObject.GetRotatePoint(dr);
                App.RotatePointList.Add(rotatePoint);
            }
        }
        
        static void DownKeyPoint()
        {
            string sql = string.Format("SELECT * FROM dbo.T_Base_KeyPoint ");
            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                KeyPoint keyPoint = GetObject.GetKeyPoint(dr);
                App.KeyPointList.Add(keyPoint);
            }
        }

        static void DownShelf()
        {
            string sql = string.Format("SELECT * FROM dbo.T_Base_Shelf ");
            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Shelf shelf = GetObject.GetShelf(dr);
                App.ShelfList.Add(shelf);
            }
        }

        static void DownAgv()
        {
            string sql = string.Format("SELECT * FROM dbo.T_Base_AGV ");
            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Agv agv = GetObject.GetAgv(dr);
                App.AgvList.Add(agv);

                Point point = App.PointList.FirstOrDefault(a => a.barCode == agv.barcode);
                if (point == null) continue;
                point.lockedAgv = agv;
            }
        }

        static void DownSTask()
        {
            string sql = string.Format(@"SELECT ts.*,c.ItemName FROM dbo.T_Task_Son ts
                                    LEFT JOIN dbo.T_Type_Config c ON ts.STaskType = c.ItemNo
                                    WHERE State IN(1, 2, 3) ORDER BY AgvNo, SerialNo");


            DataSet ds = DbHelperSQL.Query(sql);

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                GetObject.GetSTask(dr);
            }
        }

        static void DownPath()
        {
            string sql = "SELECT * FROM dbo.T_Base_PathList order by sid,SerialNo";
            DataSet ds = DbHelperSQL.Query(sql);

            List<PathPoint> listPathPoint = new List<PathPoint>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                int sID = int.Parse(dr["SID"].ToString());
                string barcode = dr["Barcode"].ToString();
                int serialNo = int.Parse(dr["serialNo"].ToString());
                int direction = int.Parse(dr["Direction"].ToString());

                PathPoint pp = new PathPoint();
                pp.SID = sID;
                pp.serialNo = serialNo;
                pp.point = App.PointList.FirstOrDefault(a => a.barCode == barcode);
                listPathPoint.Add(pp);
            }

            foreach (Agv agv in App.AgvList)
            {
                if (agv.sTaskList.Count == 0)
                    continue;

                //将此点放到对应子任务的路径中
                STask sTask = agv.sTaskList[0];
                if (listPathPoint.Exists(a => a.SID == sTask.sID))
                {
                    sTask.pathList = listPathPoint.FindAll(a => a.SID == sTask.sID);
                    sTask.pathList.Sort();
                    
                    PathGet.OriLock(sTask.pathList, agv);
                }
            }
        }
    }
}
