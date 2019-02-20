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
        //Dictionary<string, List<Dictionary<string, List<task>>>> allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
        //List<task> allManagedTasks = new List<task>();
        DAL_Comn_Excel ce = new DAL_Comn_Excel();
        List<task> allData = new List<task>();//所有原始任务
        int j = 1;//行数
        int number = 0;//指定小车任务数
        string agv = "";
        public Form1()
        {
            InitializeComponent();
            Control.CheckForIllegalCrossThreadCalls = false;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

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
        /// 读取源数据
        /// </summary>
        /// <returns></returns>
        private void getExcelData()
        {
            Microsoft.Office.Interop.Excel.Workbook wb;
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
                //return allData;
             }
            catch (Exception ex)
            {
                ce.Close();
                throw new Exception(ex.ToString());
                //return null;
            }
            
        }

        /// <summary>
        /// 将处理后的数据写入excel
        /// </summary>
        /// <param name="allManagedTasks"></param>
        private void writeDataToExcel(List<task> allManagedTasks)
        {
            Microsoft.Office.Interop.Excel.Workbook wb;
            Microsoft.Office.Interop.Excel.Worksheet ws;
            try
            {
                wb = ce.Open(textBox1.Text);
                string newSheetName = "数据";
                if (ce.sheetIsExists(newSheetName))
                {
                    ws = ce.GetSheet(newSheetName);                  
                }
                else
                {
                    ws = ce.AddSheet(newSheetName);
                }            
                if (j == 1)
                {
                    string[] title ={"任务类型","货架号","站台","建立时间","小车号","开始时间","结束时间" ,"enable",
                    "单条任务时间","充电所用时间","充电任务消耗总时间","货架任务间隔时间","货架任务总时间","货架任务时间","货架在工作台等待时间","建立回库路径时间"};
                    for (int i = 0; i < title.Length; i++)
                    {
                        ce.SetCellValue(ws, 1, i + 1, title[i]);
                    }
                    j++;
                }
               
                //int j=2;
                foreach (task ttl in allManagedTasks.OrderBy(a => a.agvNo).ThenBy(b => b.startTime))
                {
                    ce.SetCellValue(ws, j, 1, ttl.taskType);
                    ce.SetCellValue(ws, j, 2, ttl.shelfNo);
                    ce.SetCellValue(ws, j, 3, ttl.stationNo);
                    ce.SetCellValue(ws, j, 4, ttl.setupTime);
                    ce.SetCellValue(ws, j, 5, ttl.agvNo);
                    ce.SetCellValue(ws, j, 6, ttl.startTime);
                    ce.SetCellValue(ws, j, 7, ttl.endTime);
                    ce.SetCellValue(ws, j, 8, Convert.ToByte(ttl.isEnable));
                    if (ttl.singleTaskTime.ToString() != "00:00:00")
                    {
                        ce.SetCellValue(ws, j, 9, ttl.singleTaskTime.ToString());
                    }                  
                    if (ttl.chargePeriod.ToString() != "00:00:00")
                    {
                        ce.SetCellValue(ws, j, 10, ttl.chargePeriod.ToString());
                        ce.SetCellValue(ws, j, 11, ttl.chargeTotalTime.ToString());
                    }
                    if (ttl.intervalTime.ToString() != "00:00:00")
                    {
                        ce.SetCellValue(ws, j, 12, ttl.intervalTime.ToString());
                    }
                    if (ttl.shelfTotalTime.ToString() != "00:00:00")
                    {
                        ce.SetCellValue(ws, j, 13, ttl.shelfTotalTime.ToString());
                        ce.SetCellValue(ws, j, 14, ttl.shelfWorkTime.ToString());
                        ce.SetCellValue(ws, j, 15, ttl.shelfAtStationTime.ToString());
                        ce.SetCellValue(ws, j, 16, ttl.createPathTime.ToString());
                    }                   
                    j++;
                }
                //allData.RemoveAll(a => a.agvNo == agv);
                ce.Save();
                ce.Close();
            }
            catch (Exception ex)
            {
                ce.Close();
                throw new Exception(ex.ToString());
            }
            //finally
            //{
            //    button1.Enabled = true;
            //    textBox1.Text = "";
            //    label1.Text = "完成";
            //}
        }

        private void groupByAgvNo(List<task> allData)
        {
            while (allData.Count != 0)
            {
                agv = allData[0].agvNo;
                List<task> onegroup = allData.FindAll(a => a.agvNo == agv);
                number = onegroup.Count;
                groupdata(onegroup);
                allData.RemoveAll(a => a.agvNo == agv);
            }
            button1.Enabled = true;
            textBox1.Text = "";
            label1.Text = "完成";
        }


        /// <summary>
        /// 将读取的数据按小车号分组
        /// </summary>
        /// <param name="allData"></param>
        private void groupdata(List<task> allData)
        {
            Dictionary<string, List<Dictionary<string, List<task>>>> allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
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
            allgroup=manageData(allgroup);
            List<task> amt=getAllManagedData(allgroup);
            writeDataToExcel(amt);
        }

        /// <summary>
        /// 对分组后的数据进行处理，计算时间
        /// </summary>
        private Dictionary<string, List<Dictionary<string, List<task>>>> manageData(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {
            foreach (KeyValuePair<string, List<Dictionary<string, List<task>>>> eg in allgroup)
            {
                int firstshelftask = -1;
                int lastshelftask = -1;
                List<task> lastst = new List<task>();
                foreach (Dictionary<string, List<task>> ed in eg.Value)
                {
                    //var dicSort = (from objDic in ed orderby Regex.Match(objDic.Key, @"\d+") select objDic).ToList();
                    //int firstshelftask = dicSort.ToList().FindIndex(a => a.Key == (dicSort.ToList().FirstOrDefault(b => b.Key.Contains("shelf")).Key));

                    foreach (KeyValuePair<string, List<task>> et in ed)
                    {
                        if (firstshelftask == -1 && et.Key.Contains("shelf") && et.Value.Count == 2)
                        {
                            firstshelftask = eg.Value.IndexOf(ed);
                        }
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
                            if (et.Value.FindAll(a => a.isEnable).Count == 2)
                            {
                                et.Value.Find(a => a.taskType == 5).chargeTotalTime = et.Value.Find(a => a.taskType == 6).endTime - et.Value.Find(a => a.taskType == 5).setupTime;
                            }
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
                            if(thisshelftask!=firstshelftask)
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
            return allgroup;
        }

        /// <summary>
        /// 
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


        private List<task> getAllManagedData(Dictionary<string, List<Dictionary<string, List<task>>>> allgroup)
        {
            List<task> allManagedTasks = new List<task>();
            foreach (KeyValuePair<string, List<Dictionary<string, List<task>>>> eg in allgroup)
            {
                foreach(Dictionary<string, List<task>> ed in eg.Value)
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
            //allManagedTasks.OrderBy(a => a.agvNo).ThenBy(b => b.startTime); 
            return allManagedTasks;
        }

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
                label1.Text = "处理 " + textBox1.Text + " 中......";
                backgroundWorker1.RunWorkerAsync();
            }
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            if (!string.IsNullOrEmpty(textBox1.Text) && !button1.Enabled)
            {
                //label3.Text = "处理Excel数据中";
                 //allgroup = new Dictionary<string, List<Dictionary<string, List<task>>>>();
                 //allManagedTasks = new List<task>();

                 //List<task> all=getExcelData();
                 getExcelData();
                 groupByAgvNo(allData);
                 //groupdata(all);
                 //manageData();
                 //getAllManagedData(allgroup);
                 //writeDataToExcel(allManagedTasks);
                 allData = new List<task>();
                 j = 1;//行数
                 number = 0;//指定小车任务数
                 agv = "";


            }
        }

    }
}
