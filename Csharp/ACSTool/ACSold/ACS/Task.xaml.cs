using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ACS
{
    /// <summary>
    /// Task.xaml 的交互逻辑
    /// </summary>
    public partial class Task : Window
    {
        public Task()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            if (string.IsNullOrEmpty(tasktype.SelectedValue.ToString()))
            {
                MessageBox.Show("请选择任务类型");
            }
            else
            {
                string msg = "";
                string tasktp = tasktype.SelectedValue.ToString().Substring(tasktype.SelectedValue.ToString().IndexOf("Task"));
                string ws = station.SelectedItem.ToString().Substring(station.SelectedItem.ToString().IndexOf("WS"));             
                SqlParameter[] para = new SqlParameter[12];
                string[] inputParaName = { "TaskType", "ShelfNo", "PalletNo", "TaskLevel", "AgvNo", "Direction", "StationNo",
                                                 "Barcode", "FromStationNo", "TaskState", "FromStep", "AreaNo" };
                SqlDbType[] inputParaType ={SqlDbType.NVarChar,SqlDbType.NVarChar,SqlDbType.NVarChar,SqlDbType.Int,SqlDbType.NVarChar,SqlDbType.NVarChar,
                                                  SqlDbType.NVarChar,SqlDbType.NVarChar,SqlDbType.NVarChar,SqlDbType.Int,SqlDbType.Int,SqlDbType.NVarChar};
                for (int i = 0; i < inputParaName.Length; i++)
                {
                    para[i] = new SqlParameter(inputParaName[i], inputParaType[i]);
                }
                para[0].Value = tasktp;
                para[2].Value = "";
                para[3].Value = 1;               
                para[7].Value = "";
                para[8].Value = "";
                para[9].Value = 0;
                para[10].Value = 0;
                para[11].Value = "1";
                if (tasktp == "Task_ShelfOut" || tasktp == "Task_ShelfIn")
                {
                    para[1].Value = shelfNo.Text;
                    para[4].Value = "";
                    para[5].Value = "1";
                    para[6].Value = ws;
                    msg = "下发货架" + shelfNo.Text + "的" + tasktp + "任务完成\n目标站台为：" + ws;
                }
                else
                {
                    para[1].Value = "";
                    para[4].Value = agvNo.Text;
                    para[5].Value = "";
                    para[6].Value = "";
                    msg = "下发小车" + agvNo.Text + "的" + tasktp + "任务完成";
                }
                DbHelperSQL.RunProc("P_Task_Create", para);
                MessageBox.Show(msg);
                this.Close();
            }
            
            
        }

        private void tasktype_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (!string.IsNullOrEmpty(tasktype.Text))
            {
                //System.Console.WriteLine(tasktype.SelectedItem);
                //System.Console.WriteLine(tasktype.SelectedValue);
                if (tasktype.SelectedValue.ToString().Contains("Shelf"))
                {
                    shelfTask.Visibility = System.Windows.Visibility.Visible;
                    chargeTask.Visibility = Visibility.Collapsed;
                }
                else if (tasktype.SelectedItem.ToString().Contains("Charge"))
                {
                    shelfTask.Visibility = Visibility.Collapsed;
                    chargeTask.Visibility = Visibility.Visible;
                }
            }
           
        }
    }
}
