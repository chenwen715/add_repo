using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace statistics
{
    public partial class Form1 : Form
    {
        Dictionary<string, List<Dictionary<string, List<task>>>> allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
        //Dictionary<string, List<List<task>>> allshelfgroup = new Dictionary<string, List<List<task>>>();
        List<task> allManagedTasks = new List<task>();
        DAL_Comn_Excel ce = new DAL_Comn_Excel();
        int times = 2;
        string shijianduan = "";
        public Form1()
        {
            InitializeComponent();
            Control.CheckForIllegalCrossThreadCalls = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            richTextBox1.Text = "";
        }

        #region
        //private List<task> getExcelData1()
        //{
        //    List<task> allData = new List<task>();
        //    try
        //    {
        //        if (string.IsNullOrEmpty(textBox1.Text))
        //        {
        //            MessageBox.Show("请选择文件");
        //        }
        //        else
        //        {
        //            DataSet ds = new DataSet();
        //            string strExtension = System.IO.Path.GetExtension(textBox1.Text);
        //            string strConn = "";
        //            if (strExtension == ".xls")
        //            {
        //                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + textBox1.Text + ";" + "Extended Properties=Excel 8.0;";
        //            }
        //            else if (strExtension == ".xlsx")
        //            {
        //                strConn = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + textBox1.Text + ";" + "Extended Properties=Excel 12.0;";
        //                //strConn = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + textBox1.Text + ";Extended Properties='Excel 8.0; HDR=Yes; IMEX=1'";
        //            }
        //            OleDbConnection conn = new OleDbConnection(strConn);
        //            conn.Open();
        //            string strExcel = "";
        //            OleDbDataAdapter myCommand = null;
        //            System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, null);

        //            for (int n = 0; n < schemaTable.Rows.Count; n++)
        //            {
        //                if (schemaTable.Rows[n][2].ToString().Trim().EndsWith("$") && schemaTable.Rows[n][2].ToString().Trim().Contains("Sheet1"))
        //                {
        //                    string sheetName = schemaTable.Rows[n][2].ToString().Trim();
        //                    strExcel = string.Format("select * from [{0}]", sheetName);
        //                    myCommand = new OleDbDataAdapter(strExcel, strConn);
        //                    myCommand.Fill(ds, sheetName);
        //                    conn.Close();
        //                    DataTable dt = ds.Tables[sheetName];
        //                    int totalNumber = dt.Rows.Count;
        //                    for (int i = 0; i < totalNumber; i++)
        //                    {
        //                        task t = new task();
        //                        t.taskType = Convert.ToInt16(dt.Rows[i][0].ToString());
        //                        if (t.taskType == 4)
        //                        {
        //                            t.isEnable = false;
        //                        }
        //                        else
        //                        {
        //                            t.isEnable = true;
        //                        }
        //                        t.shelfNo = string.IsNullOrEmpty(dt.Rows[i][1].ToString()) ? "" : dt.Rows[i][1].ToString();
        //                        t.stationNo = dt.Rows[i][2].ToString();
        //                        t.setupTime = Convert.ToDateTime(dt.Rows[i][3].ToString());
        //                        t.agvNo = dt.Rows[i][4].ToString();
        //                        t.startTime = Convert.ToDateTime(dt.Rows[i][5].ToString());
        //                        t.endTime = Convert.ToDateTime(dt.Rows[i][6].ToString());
        //                        allData.Add(t);
        //                    }
        //                }
        //            }
        //        }
        //        return allData;
        //    }
        //    catch ( Exception ex)
        //    {
        //        throw new Exception(ex.ToString());
        //        return null; 
        //    }
        //}

        //private void writeDataToExcel1(List<task> allManagedTasks)
        //{
        //    try
        //    {
        //        string file = "D:\\task2.xlsx";
        //        string strExtension = System.IO.Path.GetExtension(file);
        //        string strConn = "";
        //        if (strExtension == ".xls")
        //        {
        //            strConn = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + file + ";" + "Extended Properties=Excel 8.0;";
        //        }
        //        else if (strExtension == ".xlsx")
        //        {
        //            //strConn = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + textBox1.Text + ";" + "Extended Properties=Excel 12.0;";
        //            strConn = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + file + ";Extended Properties='Excel 8.0; HDR=YES; IMEX=2' ";
        //        }

        //        string newSheetName = "managed";
        //        using (OleDbConnection conn = new OleDbConnection(strConn))
        //        {
        //            conn.Open();
        //            using (OleDbCommand cmd = conn.CreateCommand())
        //            {

        //                cmd.CommandText = "CREATE TABLE [" + newSheetName + "]([任务类型] INTEGER, [货架号] VarChar,[站台] VarChar,[建立时间] DateTime,[小车号] VarChar,[开始时间] DateTime,[结束时间] DateTime,"
        //          + "[enable] bit,[单条任务时间] timestamp,[充电所用时间] timestamp,[充电任务消耗总时间] timestamp,[货架任务间隔时间] timestamp,[货架任务总时间] timestamp,"
        //          + "[货架任务时间] timestamp,[货架在工作台等待时间] timestamp,[建立回库路径时间] timestamp)"; ;
        //                cmd.ExecuteNonQuery();
        //                MessageBox.Show("生成Excel文件成功......");
        //                //OleDbConnection conn = new OleDbConnection(strConn);
        //                //conn.Open();

        //                //OleDbCommand cmd = conn.CreateCommand();//创建工作表命令

        //                //cmd.CommandText = "CREATE TABLE [" + newSheetName + "]([任务类型] INTEGER, [货架号] VarChar,[站台] VarChar,[建立时间] DateTime,[小车号] VarChar,[开始时间] DateTime,[结束时间] DateTime,"
        //                //    + "[enable] bit,[单条任务时间] timestamp,[充电所用时间] timestamp,[充电任务消耗总时间] timestamp,[货架任务间隔时间] timestamp,[货架任务总时间] timestamp,"
        //                //    + "[货架任务时间] timestamp,[货架在工作台等待时间] timestamp,[建立回库路径时间] timestamp)";
        //                //cmd.ExecuteNonQuery();

        //                string strCom = "select * from [" + newSheetName + "$]";

        //                OleDbDataAdapter myCommand = new OleDbDataAdapter(strCom, conn);
        //                System.Data.OleDb.OleDbCommandBuilder builder = new OleDbCommandBuilder(myCommand);

        //                //QuotePrefix和QuoteSuffix主要是对builder生成InsertComment命令时使用。 
        //                builder.QuotePrefix = "[";     //获取insert语句中保留字符（起始位置） 
        //                builder.QuoteSuffix = "]"; //获取insert语句中保留字符（结束位置） 
        //                DataSet newds = new DataSet();
        //                myCommand.Fill(newds, newSheetName);
        //                foreach (task ttl in allManagedTasks.OrderBy(a => a.agvNo).ThenBy(b => b.startTime))
        //                {
        //                    DataRow nrow = newds.Tables[newSheetName].NewRow();
        //                    nrow[0] = ttl.taskType;
        //                    nrow[1] = ttl.shelfNo;
        //                    nrow[2] = ttl.stationNo;
        //                    nrow[3] = ttl.setupTime;
        //                    nrow[4] = ttl.agvNo;
        //                    nrow[5] = ttl.startTime;
        //                    nrow[6] = ttl.endTime;
        //                    nrow[7] = Convert.ToByte(ttl.isEnable);
        //                    nrow[8] = ttl.singleTaskTime;
        //                    nrow[9] = ttl.chargePeriod;
        //                    nrow[10] = ttl.chargeTotalTime;
        //                    nrow[11] = ttl.intervalTime;
        //                    nrow[12] = ttl.shelfTotalTime;
        //                    nrow[13] = ttl.shelfWorkTime;
        //                    nrow[14] = ttl.shelfAtStationTime;
        //                    nrow[15] = ttl.createPathTime;
        //                    newds.Tables[newSheetName].Rows.Add(nrow);
        //                }
        //                myCommand.Update(newds, newSheetName);
        //            }
        //            conn.Close();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.ToString());
        //    }
        //    finally
        //    {
        //        button1.Enabled = true;
        //        textBox1.Text = "";
        //    }
        //}
        #endregion

        /// <summary>
        /// 读取excel数据
        /// </summary>
        /// <returns></returns>
        private List<task> getExcelData()
        {
            Microsoft.Office.Interop.Excel.Workbook wb;
            List<task> allData = new List<task>();
            try
            {
                if (string.IsNullOrEmpty(textBox1.Text))
                {
                    MessageBox.Show("请选择文件");
                }
                else
                {
                    wb = ce.Open(textBox1.Text);
                    string sheetName = wb.Worksheets[1].Name;
                    Microsoft.Office.Interop.Excel.Worksheet ws = wb.Worksheets[sheetName];
                    int totalNumber = ws.UsedRange.CurrentRegion.Rows.Count;
                    for (int i = 2; i <= totalNumber; i++)
                    {
                        task t = new task();
                        t.taskType = Convert.ToInt16(ce.GetCellValue(ws, i, 1).ToString());
                        if (t.taskType == 4)
                        {
                            t.isEnable = false;
                        }
                        else
                        {
                            t.isEnable = true;
                        }
                        t.shelfNo = string.IsNullOrEmpty(ce.GetCellValue(ws, i, 2).ToString()) ? "" : ce.GetCellValue(ws, i, 2).ToString();
                        t.stationNo = ce.GetCellValue(ws, i, 3).ToString();
                        t.setupTime = Convert.ToDateTime(ce.GetCellValue(ws, i, 4).ToString());
                        t.agvNo = ce.GetCellValue(ws, i, 5).ToString();
                        t.startTime = Convert.ToDateTime(ce.GetCellValue(ws, i, 6).ToString());
                        t.endTime = Convert.ToDateTime(ce.GetCellValue(ws, i, 7).ToString());
                        allData.Add(t);
                    }
                }
                ce.Close();
                return allData;
             }
            catch (Exception ex)
            {
                ce.Close();
                throw new Exception(ex.ToString());
                //return null;
            }
            
        }

        /// <summary>
        /// 将内存数据写入excel
        /// </summary>
        /// <param name="allgroup"></param>
        private void writeDataToExcel(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {
            
            
            //Microsoft.Office.Interop.Excel.Worksheet ws = null;
            //string newSheetName = "基础数据";
            //if (ce.GetSheet(newSheetName) == null)
            //{
            //    ws = ce.AddSheet(newSheetName);
            //}
            //else
            //{
            //    ws = ce.GetSheet(newSheetName);
            //}           
            //string[] title={"任务类型","货架号","站台","建立时间","小车号","开始时间","结束时间" ,"enable",
            //    "单条任务时间","充电所用时间","充电任务消耗总时间","货架任务间隔时间","货架任务总时间","货架任务时间","建立回库路径时间",
            //    "货架在工作台等待时间","补车时间","出库任务完成间隔时间"};
            //ce.SetCellColor(ws, 1, 8, title.Length-7, Color.Green);
            //for(int i =0;i<title.Length;i++)
            //{
            //    ce.SetCellValue(ws,1,i+1,title[i]);
            //}
            //int j=2;

            allgroup=tjaData(allgroup);
            getAllManagedData(allgroup);
            tjsData(allManagedTasks);
            groupByStation(allManagedTasks);
            //tjstation(allManagedTasks);
            //foreach (task ttl in allManagedTasks.OrderBy(a => a.agvNo).ThenBy(b => b.startTime))
            //{
            //    if (ttl.possibleError)
            //    {
            //        //ce.SetCellValue(ws, j, 17, Convert.ToByte(ttl.possibleError));
            //        ce.SetCellColor(ws, j, 1,title.Length, Color.Red);
            //    }
            //    ce.SetCellValue(ws, j, 1, ttl.taskType);
            //    ce.SetCellValue(ws, j, 2, ttl.shelfNo);
            //    ce.SetCellValue(ws, j, 3, ttl.stationNo);
            //    ce.SetCellValue(ws, j, 4, ttl.setupTime);
            //    ce.SetCellValue(ws, j, 5, ttl.agvNo);
            //    ce.SetCellValue(ws, j, 6, ttl.startTime);
            //    ce.SetCellValue(ws, j, 7, ttl.endTime);
            //    ce.SetCellValue(ws, j, 8, Convert.ToByte(ttl.isEnable));
            //    if (ttl.singleTaskTime.ToString() != "00:00:00")
            //    {
            //        ce.SetCellValue(ws, j, 9, ttl.singleTaskTime.ToString());
            //    }                  
            //    if (ttl.chargePeriod.ToString() != "00:00:00")
            //    {
            //        ce.SetCellValue(ws, j, 10, ttl.chargePeriod.ToString());
            //        ce.SetCellValue(ws, j, 11, ttl.chargeTotalTime.ToString());
            //    }
            //    if (ttl.intervalTime.ToString() != "23:59:59")
            //    {
            //        ce.SetCellValue(ws, j, 12, ttl.intervalTime.ToString());
            //    }
            //    if (ttl.shelfTotalTime.ToString() != "00:00:00")
            //    {
            //        ce.SetCellValue(ws, j, 13, ttl.shelfTotalTime.ToString());
            //        ce.SetCellValue(ws, j, 14, ttl.shelfWorkTime.ToString());
            //        ce.SetCellValue(ws, j, 16, ttl.shelfAtStationTime.ToString());
            //        ce.SetCellValue(ws, j, 15, ttl.createPathTime.ToString());
            //    }
            //    if (ttl.addAGVTime.ToString() != "23:59:59")
            //    {
            //        ce.SetCellValue(ws, j, 17, ttl.addAGVTime.ToString());
            //        ce.SetCellValue(ws, j, 18, ttl.shelfOutFinishIntervalTime.ToString());
            //    }
            //    j++;
                
                
            //}
        }

        //private void tjstation(List<task> allManagedTasks2)
        //{
        //    string newSheetName = "站台任务统计";
        //    Microsoft.Office.Interop.Excel.Worksheet ws = ce.AddSheet(newSheetName);
        //    string[] title = { "站台", "货架任务数", "平均停留时间", "平均补车时间", "平均货架任务完成间隔时间" };
        //    for (int i = 0; i < title.Length; i++)
        //    {
        //        ce.SetCellValue(ws, 1, i + 1, title[i]);
        //    }
        //    int j = 2;
        //    foreach (IGrouping<string, task> group in allManagedTasks2.FindAll(a => (a.taskType == 8 || a.taskType == 9) && a.isEnable).GroupBy(a => a.stationNo))
        //    {
        //        ce.SetCellValue(ws, j, 1, group.Key);
        //        int shelftasks = allManagedTasks2.FindAll(a => a.stationNo == group.Key && a.taskType == 8 && a.isEnable).Count;
        //        ce.SetCellValue(ws, j, 2, shelftasks);
        //        ce.SetCellValue(ws, j, 3, convertTime(allManagedTasks2.FindAll(a => a.stationNo == group.Key && a.taskType == 8 && a.isEnable).Average(a => a.shelfAtStationTime.TotalSeconds)));
        //        double aa = allManagedTasks2.FindAll(a => a.stationNo == group.Key && a.taskType == 8 && a.isEnable).Sum(a => a.addAGVTime.TotalSeconds);
        //        ce.SetCellValue(ws, j, 4, (shelftasks - 1));
        //        ce.SetCellValue(ws, j, 5, convertTime(allManagedTasks2.FindAll(a => a.stationNo == group.Key && a.taskType == 8 && a.isEnable).Sum(a => a.shelfOutFinishIntervalTime.TotalSeconds) / (shelftasks - 1)));
        //        j++;
        //    }
        //}

        private Dictionary<string, List<Dictionary<string, List<task>>>> shelfData(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {

            return allgroup;
        }

        /// <summary>
        /// 统计小车任务数
        /// </summary>
        /// <param name="allManagedTasks"></param>
        private Dictionary<string, List<Dictionary<string, List<task>>>> tjaData(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {
            //string newSheetName = "小车统计信息";
            //Microsoft.Office.Interop.Excel.Worksheet ws = ce.AddSheet(newSheetName);
            //string[] title = { "小车号", "总任务数", "出入库任务数", "充电任务数", "平均充电时间", "平均充电任务消耗时间","入库比出库耗时长任务数", "用于计算任务间隔的任务数", "平均任务衔接时间", "最大任务衔接时间", "最小任务衔接时间" };
            //for (int i = 0; i < title.Length; i++)
            //{
            //    ce.SetCellValue(ws, 1, i + 1, title[i]);
            //}
            //int allchargetasks = 0;
            //double allchargetimes = 0;
            //double allchargetaskstimes = 0;
            //int allshelftasks = 0;
            //double allshelfintervaltimes = 0;
            //int ii = 2;
            foreach (KeyValuePair<string, List<Dictionary<string, List<task>>>> eg in allgroup)
            {
                //ce.SetCellValue(ws, ii, 1, eg.Key);
                int totaltasks=0;
                int totalshelftasks=0;
                int totalchargetasks=0;
                int inlargerthanout=0;
                KeyValuePair<string, List<task>> last_task = new KeyValuePair<string, List<task>>();
                List<task> interval = new List<task>();//用于计算任务间隔的货架任务数
                List<task> ct = new List<task>();//用于计算的充电任务数
                foreach(Dictionary<string, List<task>> ed in eg.Value)
                {
                    foreach (KeyValuePair<string, List<task>> et in ed)
                    {
                        if(et.Value.Find(a=>a.isEnable)!=null)
                        {
                            totaltasks++;
                            if (et.Key.Contains("charge"))
                            {
                                totalchargetasks++;
                                if (totaltasks!=1&& last_task.Key.Contains("charge"))
                                {
                                    foreach (task t in et.Value)
                                    {
                                        t.possibleError = true;
                                    }
                                }
                                ct.Add(et.Value.Find(a => a.taskType == 5));
                            }
                            else if(et.Key.Contains("shelf"))
                            {
                                totalshelftasks++;
                                if (totaltasks!=1&&last_task.Key.Contains("shelf"))//连续的2次货架任务有效，若中间有充电任务则不用于统计
                                {
                                    interval.Add(et.Value.Find(a => a.taskType == 8 && a.intervalTime.ToString() != "23:59:59"));
                                }
                                //if(et.Value.Find(a=>a.taskType==8).singleTaskTime<et.Value.Find(a=>a.taskType==9).singleTaskTime)
                                //{
                                //    inlargerthanout++;
                                //}
                            }
                        }
                        last_task = et;
                    }
                }

            //    ce.SetCellValue(ws, ii, 2, totaltasks);
            //    ce.SetCellValue(ws, ii, 3, totalshelftasks);
            //    ce.SetCellValue(ws, ii, 4, totalchargetasks);
            //    if (totalchargetasks!=0)
            //    {
            //        ce.SetCellValue(ws, ii, 5, convertTime(ct.Average(a => a.chargePeriod.TotalSeconds)));
            //        ce.SetCellValue(ws, ii, 6, convertTime(ct.Average(a => a.chargeTotalTime.TotalSeconds)));
            //        allchargetasks += totalchargetasks;
            //        allchargetimes += ct.Sum(a => a.chargePeriod.TotalSeconds);
            //        allchargetaskstimes += ct.Sum(a => a.chargeTotalTime.TotalSeconds);
            //    }
            //    if (totalshelftasks > 0)
            //    {
            //        ce.SetCellValue(ws, ii, 7, inlargerthanout);
            //        ce.SetCellValue(ws, ii, 8, interval.Count);
            //        if (interval.Count > 0)
            //        {
            //            ce.SetCellValue(ws, ii, 9, convertTime(interval.Average(a => a.intervalTime.TotalSeconds)));
            //            ce.SetCellValue(ws, ii, 10, interval.Max(a => a.intervalTime).ToString());
            //            ce.SetCellValue(ws, ii, 11, interval.Min(a => a.intervalTime).ToString());
            //        }                                   
            //        allshelftasks += interval.Count;
            //        allshelfintervaltimes += interval.Sum(a => a.intervalTime.TotalSeconds);
            //    }                
            //    ii++;
            }
            
            //ce.SetCellValue(ws, ii, 1, "平均");
            //if (allchargetasks > 0)
            //{
            //    ce.SetCellValue(ws, ii, 5, convertTime(allchargetimes / allchargetasks));
            //    ce.SetCellValue(ws, ii, 6, convertTime(allchargetaskstimes / allchargetasks));
            //}
            //if (allshelftasks > 0)
            //{
            //    ce.SetCellValue(ws, ii, 9, convertTime(allshelfintervaltimes / allshelftasks));
            //}
            return allgroup;

        }
        /// <summary>
        /// 统计货架任务信息
        /// </summary>
        /// <param name="allManagedTasks"></param>
        private void tjsData(List<task> allManagedTasks)
        {
            Microsoft.Office.Interop.Excel.Worksheet ws=null;
            string newSheetName = "货架任务统计";
            if (!ce.isExistSheet(newSheetName))
            {
                ws = ce.AddSheet(newSheetName);
            }
            else
            {
                ws = ce.GetSheet(newSheetName);
            }           
            string[] title ={"时间段","货架任务数","平均出库时间","最长出库时间","最短出库时间","平均入库时间","最长入库时间","最短入库时间"
                                ,"平均货架任务总时间","最长货架任务总时间","最短货架任务总时间","平均货架任务时间","最长货架任务时间","最短货架任务时间"
                                ,"平均货架在工作台等待时间","最长货架在工作台等待时间","最短货架在工作台等待时间","平均建立回库路径时间",
                                "最长建立回库路径时间","最短建立回库路径时间"};
            for (int i = 0; i < title.Length; i++)
            {
                ce.SetCellValue(ws, 1, i + 1, title[i]);
            }
            List<task> shelftasks = allManagedTasks.FindAll(a => a.shelfTotalTime.ToString() != "00:00:00");
            ce.SetCellValue(ws, times, 1, shijianduan);
            ce.SetCellValue(ws, times, 2, shelftasks.Count);
            if (allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Count != 0)
            {
                ce.SetCellValue(ws, times, 3, convertTime(allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Average(a => a.singleTaskTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 4, allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Max(a => a.singleTaskTime).ToString());
                ce.SetCellValue(ws, times, 5, allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Min(a => a.singleTaskTime).ToString());
            }
            if (allManagedTasks.FindAll(a => a.taskType == 9 && a.isEnable).Count != 0)
            {
                ce.SetCellValue(ws, times, 6, convertTime(allManagedTasks.FindAll(a => a.taskType == 9 && a.isEnable).Average(a => a.singleTaskTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 7, allManagedTasks.FindAll(a => a.taskType == 9 && a.isEnable).Max(a => a.singleTaskTime).ToString());
                ce.SetCellValue(ws, times, 8, allManagedTasks.FindAll(a => a.taskType == 9 && a.isEnable).Min(a => a.singleTaskTime).ToString());
            }
            if (shelftasks.Count != 0)
            {
                ce.SetCellValue(ws, times, 9, convertTime(shelftasks.Average(a => a.shelfTotalTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 10, shelftasks.Max(a => a.shelfTotalTime).ToString());
                ce.SetCellValue(ws, times, 11, shelftasks.Min(a => a.shelfTotalTime).ToString());
                ce.SetCellValue(ws, times, 12, convertTime(shelftasks.Average(a => a.shelfWorkTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 13, shelftasks.Max(a => a.shelfWorkTime).ToString());
                ce.SetCellValue(ws, times, 14, shelftasks.Min(a => a.shelfWorkTime).ToString());
                ce.SetCellValue(ws, times, 15, convertTime(shelftasks.Average(a => a.shelfAtStationTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 16, shelftasks.Max(a => a.shelfAtStationTime).ToString());
                ce.SetCellValue(ws, times, 17, shelftasks.Min(a => a.shelfAtStationTime).ToString());
                ce.SetCellValue(ws, times, 18, convertTime(shelftasks.Average(a => a.createPathTime.TotalSeconds)));
                ce.SetCellValue(ws, times, 19, shelftasks.Max(a => a.createPathTime).ToString());
                ce.SetCellValue(ws, times, 20, shelftasks.Min(a => a.createPathTime).ToString());
            }            

        }

        /// <summary>
        /// 将double类型数据转为hh:mm:ss格式的字符串
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        private string convertTime(double t)
        {
            int h = Convert.ToInt16(Math.Floor(t /3600));
            int m = Convert.ToInt16(Math.Floor((t-h*3600) / 60));
            int s = Convert.ToInt16(Math.Round(t - h * 3600 - 60 * m));
            return h.ToString().PadLeft(2, '0') + ":" + m.ToString().PadLeft(2, '0') + ":" + s.ToString().PadLeft(2, '0');

        }

        /// <summary>
        /// 将所有数据按小车编号分组，格式：{小车号1：[{"chargexx":[task1,task2]},{"shelfxx":[task1,task2,task3]},{"otherxx":[task1]}...],小车号2：[]...}
        /// </summary>
        /// <param name="allData"></param>
        private void groupdata(List<task> allData)
        {
            foreach (IGrouping<string, task> group in allData.GroupBy(a => a.agvNo))
            {
                //Dictionary<string, List<List<task>>> eachgroup = new Dictionary<string, List<List<task>>>();
                List<Dictionary<string, List<task>>> eachgroup = new List<Dictionary<string, List<task>>>();
                List<task> newtasks = new  List<task>();
                int i = 1;
                foreach (task tsk in group.OrderBy(a => a.startTime))
                {
                    if (tsk.taskType == 4)
                    {
                        Dictionary<string, List<task>> tdfour = new Dictionary<string, List<task>>();
                        List<task> tfour = new List<task>();
                        tfour.Add(tsk);
                        tdfour.Add("other"+i, tfour);
                        eachgroup.Add(tdfour);                                                
                    }
                    else
                    {
                        if (tsk.taskType == 8 || tsk.taskType == 9)
                        {
                            TimeSpan delt=tsk.endTime - tsk.startTime;
                            //System.Console.WriteLine(delt);
                            tsk.singleTaskTime = delt;
                        }
                        else
                        {
                            TimeSpan delt = tsk.endTime - tsk.setupTime;
                            //System.Console.WriteLine(delt);
                            tsk.singleTaskTime = delt;
                        }
                        if (tsk.taskType == 5 || tsk.taskType == 8)
                        {
                            if (newtasks.Count != 0)
                            {
                                eachgroup.Add(insert(newtasks, i));
                            }
                            newtasks = new List<task>();
                            newtasks.Add(tsk);
                        }
                        else if (tsk.taskType == 6)
                        {
                            if (newtasks.Find(a => a.taskType == 5) != null && newtasks.Count==1)
                            {
                                newtasks.Add(tsk);
                            }
                            else
                            {
                                if (newtasks.Count != 0)
                                {
                                    eachgroup.Add(insert(newtasks, i));
                                }
                                newtasks = new List<task>();
                                tsk.isEnable = false;
                                newtasks.Add(tsk);
                            }
                        }
                        else if (tsk.taskType == 9)
                        {
                            if (newtasks.Find(a => a.taskType == 8) != null && newtasks.Count == 1)
                            {
                                newtasks.Add(tsk);
                            }
                            else
                            {
                                if (newtasks.Count != 0)
                                {
                                    eachgroup.Add(insert(newtasks, i));
                                }
                                newtasks = new List<task>();
                                newtasks.Add(tsk);
                            }
                        }
                        else if (tsk.taskType == 7)
                        {
                            if (newtasks.Find(a => a.taskType == 5) != null && newtasks.Find(a => a.taskType == 6) != null && newtasks.Count == 2)
                            {
                                newtasks.Add(tsk);
                            }
                            else if (newtasks.Find(a => a.taskType == 6) != null && newtasks.Count == 1)
                            {
                                newtasks.Add(tsk);
                                foreach (task t1 in newtasks)
                                {
                                    t1.isEnable = false;
                                }
                            }
                            else
                            {
                                if (newtasks.Count != 0)
                                {
                                    eachgroup.Add(insert(newtasks, i));
                                }
                                newtasks = new List<task>();
                                tsk.isEnable = false;                               
                                newtasks.Add(tsk);
                            }
                        }
                    }
                    i++;
                }
                if (newtasks.Count != 0)
                {
                    eachgroup.Add(insert(newtasks, i));
                }
                allgroup.Add(group.Key, eachgroup);
            }
        }

        /// <summary>
        /// 按站台处理
        /// </summary>
        private void groupByStation(List<task> allManagedTasks1)
        {
            string newSheetName = "站台任务统计";
            Microsoft.Office.Interop.Excel.Worksheet ws = null;
            if (!ce.isExistSheet(newSheetName))
            {
                ws = ce.AddSheet(newSheetName);
            }
            else
            {
                ws = ce.GetSheet(newSheetName);
            }           
            //string[] title1 = { "站台", "货架任务数", "平均停留时间", "平均补车时间", "平均货架任务完成间隔时间" };
            string[] title = { "时间段", "货架任务数", "平均停留时间", "平均补车时间", "平均货架任务完成间隔时间" };
            TimeSpan totaladd = new TimeSpan();
            TimeSpan totalfinish = new TimeSpan();
            int totaltasks = 0;
            for (int i = 0; i < title.Length; i++)
            {
                ce.SetCellValue(ws, 1, i + 1, title[i]);
            }
            //int j = 2;
            allManagedTasks = new List<task>();         
            foreach (IGrouping<string, task> group in allManagedTasks1.FindAll(a => (a.taskType == 8 || a.taskType == 9)&&a.isEnable).GroupBy(a => a.stationNo))
            {
                List<List<task>> eachgroup = new List<List<task>>();
                List<task> newtasks = new List<task>();
                //TimeSpan a1 = new TimeSpan();
                //TimeSpan a2 = new TimeSpan();
                foreach (task tsk in group.OrderBy(a => a.endTime))
                {
                    if (tsk.taskType == 8)
                    {
                        newtasks = new List<task>();
                        newtasks.Add(tsk);
                        eachgroup.Add(newtasks);
                    }
                    else
                    {
                        foreach (List<task> ttl in eachgroup)
                        {
                            if (ttl.Count == 1 && tsk.agvNo == ttl[0].agvNo)
                            {
                                ttl.Add(tsk);
                                break;
                            }
                        }
                    }                        
                }
                for (int i = 0; i < eachgroup.Count;i++ )
                {
                    if (i > 0)
                    {
                        eachgroup[i].Find(a => a.taskType == 8).addAGVTime = eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 9).startTime;
                        eachgroup[i].Find(a => a.taskType == 8).shelfOutFinishIntervalTime = eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 8).endTime;
                        //a1 += eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 9).startTime;
                        //a2 += eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 8).endTime;

                        totaltasks += 1;
                        totaladd += eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 9).startTime;
                        totalfinish += eachgroup[i].Find(a => a.taskType == 8).endTime - eachgroup[i - 1].Find(a => a.taskType == 8).endTime;
                    }
                    
                    allManagedTasks.Add(eachgroup[i].Find(a => a.taskType == 8));
                    allManagedTasks.Add(eachgroup[i].Find(a => a.taskType == 9));
                }

                //ce.SetCellValue(ws, j, 1, group.Key);
                //int shelftasks = allManagedTasks.FindAll(a => a.stationNo == group.Key&&a.taskType==8&&a.isEnable).Count;
                //ce.SetCellValue(ws, j, 2, shelftasks);
                //ce.SetCellValue(ws, j, 3, convertTime(allManagedTasks.FindAll(a => a.stationNo == group.Key && a.taskType == 8 && a.isEnable).Average(a => a.shelfAtStationTime.TotalSeconds)));
                //if (shelftasks > 1)
                //{
                //    ce.SetCellValue(ws, j, 4, convertTime(a1.TotalSeconds/ (shelftasks - 1)));
                //    ce.SetCellValue(ws, j, 5, convertTime(a2.TotalSeconds / (shelftasks - 1)));
                //}
                //j++;               
            }
            ce.SetCellValue(ws, times, 1, shijianduan);
            ce.SetCellValue(ws, times, 2, allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Count);
            if (allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Count != 0)
            {
                ce.SetCellValue(ws, times, 3, convertTime(allManagedTasks.FindAll(a => a.taskType == 8 && a.isEnable).Average(a => a.shelfAtStationTime.TotalSeconds)));
            }          
            if (totaltasks > 1)
            {
                ce.SetCellValue(ws, times, 4, convertTime(totaladd.TotalSeconds / totaltasks));
                ce.SetCellValue(ws, times, 5, convertTime(totalfinish.TotalSeconds / totaltasks));
            }
            allManagedTasks.AddRange(allManagedTasks1.FindAll(a => !a.isEnable || a.taskType == 5 || a.taskType == 6 || a.taskType == 7));
        }

        /// <summary>
        /// 处理分组后的数据
        /// </summary>
        private void manageData()
        {
            foreach (KeyValuePair<string, List<Dictionary<string, List<task>>>> eg in allgroup)
            {
                int firstshelftask = -1;
                int lastshelftask = -1;
                List<task> lastst = new List<task>();//记录上一条任务
                foreach (Dictionary<string, List<task>> ed in eg.Value)
                {
                    //var dicSort = (from objDic in ed orderby Regex.Match(objDic.Key, @"\d+") select objDic).ToList();
                    //int firstshelftask = dicSort.ToList().FindIndex(a => a.Key == (dicSort.ToList().FirstOrDefault(b => b.Key.Contains("shelf")).Key));

                    foreach (KeyValuePair<string, List<task>> et in ed)
                    {
                        //找到第一个货架任务的下标
                        if (firstshelftask == -1 && et.Key.Contains("shelf") && et.Value.Count == 2)
                        {
                            firstshelftask = eg.Value.IndexOf(ed);
                        }
                        //充电任务计算充电所用时间和充电任务消耗总时间
                        if (et.Key.Contains("charge"))
                        {
                            //只有充电和取消充电，没有回家任务且后续未执行货架出入库的数据无效
                            if (et.Value.Count == 2 && et.Value.Find(a => a.isEnable) != null && eg.Value.IndexOf(ed) >= eg.Value.Count - 1)
                            {
                                foreach (task tas in et.Value)
                                {
                                    tas.isEnable = false;
                                }
                            }
                            if (et.Value.Find(a => a.isEnable) != null)
                            {
                                et.Value.Find(a => a.taskType == 5).chargePeriod = et.Value.Find(a => a.taskType == 6).startTime - et.Value.Find(a => a.taskType == 5).endTime;
                            }
                            //只有充电和取消充电任务
                            if (et.Value.FindAll(a => a.isEnable).Count == 2)
                            {
                                et.Value.Find(a => a.taskType == 5).chargeTotalTime = et.Value.Find(a => a.taskType == 6).endTime - et.Value.Find(a => a.taskType == 5).setupTime;
                            }
                            //有充电、取消充电和回家任务
                            else if (et.Value.FindAll(a => a.isEnable).Count == 3)
                            {
                                et.Value.Find(a => a.taskType == 5).chargeTotalTime = et.Value.Find(a => a.taskType == 7).endTime - et.Value.Find(a => a.taskType == 5).setupTime;
                            }
                        }
                        else if (et.Key.Contains("shelf") && et.Value.Find(a => a.isEnable) != null)
                        {
                            if (et.Value.FindAll(a => a.isEnable).Count == 2)
                            {
                                et.Value.Find(a => a.taskType == 8).shelfTotalTime = et.Value.Find(a => a.taskType == 9).endTime - et.Value.Find(a => a.taskType == 8).startTime;
                                et.Value.Find(a => a.taskType == 8).shelfWorkTime = et.Value.Find(a => a.taskType == 9).singleTaskTime + et.Value.Find(a => a.taskType == 8).singleTaskTime;
                                et.Value.Find(a => a.taskType == 8).shelfAtStationTime = et.Value.Find(a => a.taskType == 8).shelfTotalTime - et.Value.Find(a => a.taskType == 8).shelfWorkTime;
                                et.Value.Find(a => a.taskType == 8).createPathTime = et.Value.Find(a => a.taskType == 9).startTime - et.Value.Find(a => a.taskType == 9).setupTime;
                            }
                            int thisshelftask = eg.Value.IndexOf(ed);
                            //if (thisshelftask != firstshelftask && thisshelftask - lastshelftask==1)//计算连续2次货架任务之间的时间间隔，第一个任务不计算
                            if (thisshelftask != firstshelftask && lastst.Count==2)//任务是否连续由tjaData方法控制
                            {
                                et.Value.Find(a => a.taskType == 8).intervalTime = et.Value.Find(a => a.taskType == 8).startTime - lastst.Find(a => a.taskType == 9).endTime;
                            }
                            if (lastshelftask == -1 || lastshelftask < thisshelftask)
                            {
                                lastshelftask = thisshelftask;
                                lastst = et.Value;
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 将list转换为dictionary
        /// </summary>
        /// <param name="newtasks"></param>
        /// <param name="i"></param>
        /// <returns></returns>
        private Dictionary<string, List<task>> insert(List<task> newtasks, int i)
        {
            Dictionary<string, List<task>> newtasksd = new Dictionary<string, List<task>>();
            if (newtasks[0].taskType == 5 || newtasks[0].taskType == 6 || newtasks[0].taskType == 7)
            {
                if (newtasks.Count == 2 && newtasks[0].taskType == 5 || newtasks.Count == 3)
                {

                }
                else
                {
                    foreach (task it in newtasks)
                    {
                        it.isEnable = false;
                    }
                }
                newtasksd.Add("charge" + i, newtasks);
            }
            else
            {
                if (newtasks[0].taskType == 8 && newtasks.Count == 1)
                {
                    foreach (task it in newtasks)
                    {
                        it.isEnable = false;
                    }
                }
                newtasksd.Add("shelf" + i, newtasks);
            }
            return newtasksd;
        }

        /// <summary>
        /// 将分组数据拆开
        /// </summary>
        /// <param name="allgroup"></param>
        private void getAllManagedData(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {
            foreach (KeyValuePair<string, List<Dictionary<string, List<task>>>> eg in allgroup)
            {
                foreach (Dictionary<string, List<task>> ed in eg.Value)
                {
                    foreach (KeyValuePair<string, List<task>> et in ed)
                    {
                        foreach (task t in et.Value)
                        {
                            allManagedTasks.Add(t);
                        }
                    }
                }
            }
            allManagedTasks.OrderBy(a => a.agvNo).ThenBy(b => b.startTime);          
        }

        /// <summary>
        /// 选择处理文件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            openFileDialog1.Multiselect = true;
            openFileDialog1.Title = "请选择文件夹";
            openFileDialog1.InitialDirectory = "d:\\";
            //openFileDialog1.Filter = "ext files (*.xlsx)|*.xlsx|All files(*.*)|*>**";
            openFileDialog1.RestoreDirectory = true;
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                textBox1.Text = openFileDialog1.FileName;
                button1.Enabled = false;
                richTextBox1.Text += DateTime.Now.ToString() + "\t处理 " + textBox1.Text + " 中......\n";
                backgroundWorker1.RunWorkerAsync();
            }
        }

        /// <summary>
        /// 后台处理数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            if (!string.IsNullOrEmpty(textBox1.Text) && !button1.Enabled)
            {
                times = 2;
                shijianduan = "";
                TimeSpan sampletime=TimeSpan.FromMinutes(20);
                Microsoft.Office.Interop.Excel.Workbook wb;
                //label3.Text = "处理Excel数据中";
                 List<task> alls=getExcelData();
                 DateTime firsttaskst = alls.OrderBy(a => a.startTime).FirstOrDefault().startTime;
                 DateTime lasktasket = alls.OrderByDescending(a => a.endTime).FirstOrDefault().endTime;
                 if (lasktasket - firsttaskst <= sampletime)
                 {
                     shijianduan = firsttaskst.ToString() + "-" + lasktasket.ToString();
                     allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
                     allManagedTasks = new List<task>();
                     List<task> all = alls;
                     groupdata(all);
                     manageData();
                     //getAllManagedData(allgroup);
                     try
                     {
                         wb = ce.Open(textBox1.Text);
                         writeDataToExcel(allgroup);
                         ce.Save();
                         ce.Close();
                     }
                     catch (Exception ex)
                     {
                         ce.Close();
                         throw new Exception(ex.ToString());
                     }
                     finally
                     {
                         button1.Enabled = true;
                         textBox1.Text = "";
                         richTextBox1.Text += DateTime.Now.ToString() + "\t完成\n";

                     }                   
                 }
                 else
                 {
                     try
                     {
                         wb = ce.Open(textBox1.Text);
                         while (firsttaskst + sampletime <= lasktasket)
                         {
                             shijianduan = firsttaskst.ToString() + "-" + (firsttaskst + sampletime).ToString();
                             allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
                             allManagedTasks = new List<task>();
                             List<task> all = alls.FindAll(a => a.startTime >= firsttaskst && a.endTime <= (firsttaskst + sampletime));
                             groupdata(all);
                             manageData();
                             //getAllManagedData(allgroup);
                             writeDataToExcel(allgroup);
                             firsttaskst += TimeSpan.FromMinutes(1);
                             times++;
                         }
                         if (firsttaskst + sampletime != lasktasket)
                         {
                             shijianduan = firsttaskst.ToString() + "-" + lasktasket.ToString();
                             allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
                             allManagedTasks = new List<task>();
                             List<task> all1 = alls.FindAll(a => a.startTime >= firsttaskst && a.endTime <= lasktasket);
                             groupdata(all1);
                             manageData();
                             //getAllManagedData(allgroup);
                             writeDataToExcel(allgroup);
                         }
                         ce.Save();
                         ce.Close();
                     }
                     catch (Exception ex)
                     {
                         ce.Close();
                         throw new Exception(ex.ToString());
                     }
                     finally
                     {
                         button1.Enabled = true;
                         textBox1.Text = "";
                         richTextBox1.Text += DateTime.Now.ToString() + "\t完成\n";

                     }                 
                     
                 }
                
            }
        }

    }
}
