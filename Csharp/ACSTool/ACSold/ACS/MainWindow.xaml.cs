using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;

namespace ACS
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private Thread thSocket;
        private Thread taskSocket;
        private Socket SvrSocket;
        
        List<Point> tmppl = new List<Point>();
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            App.AppDispatcher = this.Dispatcher;
            App.WinMain = this;

            //设置全屏
            //Width = SystemParameters.PrimaryScreenWidth;
            //Height = SystemParameters.WorkArea.Height;
            //Left = (SystemParameters.PrimaryScreenWidth - this.Width) / 2;
            //Top = (SystemParameters.WorkArea.Height - this.Height) / 2;
            App.Canvas_Monit = Canvas_Monitor;
            
            //初始化数据
            Down.InitData();
            CanvasInit();
            DrawPPoint();
            AgvPointSet();
            DGrid_ExecUnit.ItemsSource = App.AgvList;

            //做任务
            taskSocket = new Thread(TaskDoing);
            taskSocket.IsBackground = true;
            taskSocket.Start();

            //和AGV通讯
            thSocket = new Thread(SocketBuild);
            thSocket.IsBackground = true;
            thSocket.Start();
        }

       

        void Test()
        {
            string sql = "Select * from T_Base_Point ";
            DataSet ds = DbHelperSQL.Query(sql);

            TimeSpan ts1 = new TimeSpan(DateTime.Now.Ticks);

            string sql1 = "";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string PointNo = dr["PointNo"].ToString();
                sql1 = "UPDATE dbo.T_Base_Point SET IsLocking = 0 WHERE PointNo = '" + PointNo + "';";
                DbHelperSQL.ExecuteSql(sql1);
            }

            TimeSpan ts2 = new TimeSpan(DateTime.Now.Ticks);
            TimeSpan ts3 = ts2.Subtract(ts1).Duration();
            int milli1 = ts3.Milliseconds;
            App.ExFile.MessageLog("计算差值", "1|" + ts2.Milliseconds + "-" + ts1.Milliseconds + "="  + ts3.Milliseconds);


            TimeSpan ts4 = new TimeSpan(DateTime.Now.Ticks);
            string sql2 = "";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string PointNo = dr["PointNo"].ToString();
                sql2 += "UPDATE dbo.T_Base_Point SET IsLocking = 0 WHERE PointNo = '" + PointNo + "';";
            }
            DbHelperSQL.ExecuteSql(sql1);

            TimeSpan ts5 = new TimeSpan(DateTime.Now.Ticks);
            TimeSpan ts6 = ts4.Subtract(ts5).Duration();
            App.ExFile.MessageLog("计算差值", "2|" + ts5.Milliseconds + "-" + ts4.Milliseconds + "=" + ts6.Milliseconds);
        }

        private void TaskDoing()
        {
            while (true)
            {
                if (Commond.IsClose)
                    break;

                Task.DoWork();
                Thread.Sleep(2000);
            }
        }

        private void SocketBuild()
        {
            if (SvrSocket != null)
            {
                SvrSocket.Close();
                SvrSocket = null;
            }
            try
            {
                IPAddress ip = IPAddress.Parse(App.Ip);
                IPEndPoint ipe = new IPEndPoint(ip, App.Port);
                //Socket 
                SvrSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                SvrSocket.Bind(ipe);

                ManageTcp.ServerListen(App.ServerConactNum, SvrSocket);
            }
            catch (Exception Ex)
            {
                App.ExFile.MessageError( "SocketBuild", "创建AGV监听线程失败：" + Ex.ToString());
            }
        }

        #region 界面操作

        /// <summary>
        /// 左键拖框事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Window_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            DragMove();
        }

        /// <summary>
        /// 最小化按钮事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnMin_Click(object sender, RoutedEventArgs e)
        {
            this.WindowState = System.Windows.WindowState.Minimized;
        }

        /// <summary>
        /// 最大化按钮事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnMax_Click(object sender, RoutedEventArgs e)
        {
            if (WindowState == WindowState.Normal)
            {
                WindowState = WindowState.Maximized;
            }
            else if (WindowState == WindowState.Maximized)
            {
                WindowState = WindowState.Normal;
            }
        }

        /// <summary>
        /// 关闭按钮事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            Commond.IsClose = true;
            this.Close();
        }

        /// <summary>
        /// 菜单栏点击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void StackPanel_Click(object sender, RoutedEventArgs e)
        {
            Button btn = e.OriginalSource as Button;
            if (btn == null) return;
            if (btn.Name == Btn_Test.Name)
            {
                ACS.Task TaskWindow = new Task();
                TaskWindow.Show();
            }
        }

        /// <summary>
        /// 显示路径
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MItem_DisplayPath_Click(object sender, RoutedEventArgs e)
        {
            //if (DGrid_ExecUnit.SelectedItem == null) return;
            //ExecUnit agv = DGrid_ExecUnit.SelectedItem as ExecUnit;
            //if (agv._EuCTasksList.Count <= 0) return;
            //agv._IsShowEuPath = true;
            //App.BllCom.ShowPath(agv._EuTaskNo);
        }

        /// <summary>
        /// 隐藏路径
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MItem_HidePath_Click(object sender, RoutedEventArgs e)
        {
            //if (DGrid_ExecUnit.SelectedItem == null) return;
            //ExecUnit agv = DGrid_ExecUnit.SelectedItem as ExecUnit;
            //Sharp.PathHide(agv._ExecCode);

            //agv._IsShowEuPath = false;
        }

        /// <summary>
        /// 异常信息清除
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            TBox_EMessage.Clear();
        }
        #endregion

        //private void Button_Click(object sender, RoutedEventArgs e)
        //{
        //    Commond.TestAgvNo = AgvNo.Text;
        //}
        private void CanvasInit()
        {
            App.pointList.Sort(Comparisony);
            App.maxY = App.pointList[0].y;
            //App.minY = App.pointList[App.pointList.Count - 1].y;
            App.minY = 2;
            App.pointList.Sort(Comparisonx);
            //App.minX = App.pointList[0].x;
            App.minX = 0;
            App.maxX = App.pointList[App.pointList.Count - 1].x;

            int[] csize = MoniterAreaInit();
            Canvas_Monitor.Width = csize[0];
            Canvas_Monitor.Height = csize[1];
        }

        private void DrawPPoint()
        {
            foreach (Point p in App.pointList)
            {
                System.Console.Write(p.x.ToString() + p.y.ToString());
                int pointSize = Radius(p);
                Ellipse elli = new Ellipse();
                elli.ToolTip = string.Format("x:{0} y:{1}", p.x, p.y);//鼠标悬浮到该点上时显示
                elli.Width = pointSize;//设置点的大小
                elli.Height = pointSize;//设置点的大小，点为圆时，width和height值一样
                /*
               * D1、普通行走点；（黑）  
               * D3、充电点；（绿）
               * D4、站台点；（红）
               * D5、站台附属点；（蓝）
               * D6、货架点；（黑）
               */
                switch (p.pointType)
                {
                    case PointType.D1:
                    case PointType.D6:
                        elli.Fill = new SolidColorBrush(Colors.Black);
                        break;
                    case PointType.D3:
                        elli.Fill = new SolidColorBrush(Colors.Green);
                        break;
                    case PointType.D4:
                        elli.Fill = new SolidColorBrush(Colors.Red);
                        break;
                    case PointType.D5:
                        elli.Fill = new SolidColorBrush(Colors.Blue);
                        break;
                    default:
                        break;
                }
                int[] xy = DrawSharp(
                    p.x, p.y, App.GsWidth, App.GsHeight, pointSize);
                elli.SetValue(Canvas.TopProperty, (double)xy[1]);//设置点距幕布顶端的距离
                elli.SetValue(Canvas.LeftProperty, (double)xy[0]);//设置点距幕布左端的距离
                Canvas_Monitor.Children.Add(elli);//将点添加到幕布中，显示
                App.PPSharp.Add(elli);//将点添加到地图点显示集合中
            }
        }

        public void AgvPointSet()
        {
            foreach (Agv agv in App.AgvList)
            {
                Ellipse Elps = new Ellipse();
                Elps.Name = agv.agvNo;
                Elps.ToolTip = Elps.Name;
                Elps.Width = 40;
                Elps.Height = 40;
                Elps.Fill = new SolidColorBrush(Colors.Transparent);
                Elps.Stroke = new SolidColorBrush(Colors.Tan);
                Elps.StrokeThickness = 3;

                Point p = App.pointList.Find(a => a.barCode==agv.barcode);

                if (p != null)
                {
                    int r = Radius(p);
                    int[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, 40);
                    Elps.SetValue(Canvas.TopProperty, (double)xy[1]);
                    Elps.SetValue(Canvas.LeftProperty, (double)xy[0]);
                }

                if (!agv.isEnable)
                {
                    Elps.Visibility = System.Windows.Visibility.Collapsed;
                }
                else
                {
                    Elps.Visibility = System.Windows.Visibility.Visible;
                }
                Canvas_Monitor.Children.Add(Elps);
                App.AgvSharp.Add(Elps);
            }
        }

        private int[] MoniterAreaInit()
        {
            //获取xy方向的最大值


            long pWCount = App.maxX - App.minX + 1;
            int AreaWidth = (int)(pWCount * (App.GsWidth + 2) + pWCount);

            long pHCount = App.maxY - App.minY + 1;
            int AreaHeight = (int)(pHCount * (App.GsHeight + 2) + pHCount);

            //long pWCount = App.maxX - App.minX + 1;
            //int AreaWidth = (int)((pWCount + 1) * App.GsWidth + 8 * pWCount);

            //long pHCount = App.maxY - App.minY + 1;
            //int AreaHeight = (int)((pHCount + 1) * App.GsHeight + 8 * pWCount);

            return new int[] { AreaWidth, AreaHeight };
        }

        /// <summary>
        /// 计算点在幕布中的位置（坐标）
        /// </summary>
        /// <param name="p1">点x坐标</param>
        /// <param name="p2">点y坐标</param>
        /// <param name="p3">间距宽</param>
        /// <param name="p4">间距高</param>
        /// <returns></returns>
        private int[] DrawSharp(int p1, int p2, int p3, int p4, int size)
        {
            int y = (App.maxY - p2) * p4 - size / 2 ;
            int x = (p1 - App.minX) * p3 - size / 2 ;
            return new int[] { x, y };
        }

        private int Comparisony(Point x, Point y)
        {
            return y.y.CompareTo(x.y);
        }

        private int Comparisonx(Point x, Point y)
        {
            return x.x.CompareTo(y.x);
        }

        private int Radius(Point p)
        {
            int c = 0;
            switch (p.pointType)
            {
                case PointType.D1:
                case PointType.D6:
                    c = 8;
                    break;
                case PointType.D3:
                case PointType.D4:
                case PointType.D5:
                    c = 12;
                    break;
                default:
                    c = 6;
                    break;
            }
            return c;
        }

        

    }

      /// <summary>
        /// 设置路径点显示信息
        /// </summary>
   

    public class MakeupFonts : System.Windows.Markup.MarkupExtension
    {
        private string SizeType;
        public MakeupFonts(string fontType)
        { SizeType = fontType; }
        public override object ProvideValue(IServiceProvider Isp)
        {
            double FontSize = 0d;
            switch (SizeType)
            {
                case "Title":
                    FontSize = 20;
                    break;
                case "Normal":
                    FontSize = 12;
                    break;
                case "BottomTitle":
                    FontSize = 20;
                    break;

            }
            return FontSize;
        }
    }

    //定义值转换器
    [ValueConversion(typeof(string), typeof(string))]
    //小车背景色
    public class AgvBackGroundConvert : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value == null) return new SolidColorBrush(Colors.Transparent);

            if (int.Parse(value.ToString()) == 0)
            {
                return new SolidColorBrush(Colors.Transparent);
            }
            else if (int.Parse(value.ToString()) == 1)
            {
                return new SolidColorBrush(Colors.Red);
            }
            else if (int.Parse(value.ToString()) == 2)
            {
                return new SolidColorBrush(Colors.LightGreen);
            }
            else if (int.Parse(value.ToString()) == 3)
            {
                return new SolidColorBrush(Colors.LightSkyBlue);
            }
            else if (int.Parse(value.ToString()) == 4)
            {
                return new SolidColorBrush(Colors.LightYellow);
            }
            else if (int.Parse(value.ToString()) == 90)
            {
                return new SolidColorBrush(Colors.LightGray);
            }
            else
            {
                return new SolidColorBrush(Colors.Red);
            }
            //return Application.res
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    //定义值转换器
    [ValueConversion(typeof(string), typeof(string))]
    //小车状态说明
    public class AgvStatusConvert : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value == null) return "";

            if (value.ToString() == "1")
            {
                return "低位";
            }
            else if (value.ToString() == "2")
            {
                return "中位";
            }
            else if (value.ToString() == "3")
            {
                return "高位";
            }
            else if (value.ToString() == "10")
            {
                return "自动、无码";
            }
            else if (value.ToString() == "11")
            {
                return "自动、空闲";
            }
            else if (value.ToString() == "12")
            {
                return "自动、歪码";
            }
            else if (value.ToString() == "13")
            {
                return "忙碌";
            }
            else if (value.ToString() == "14")
            {
                return "充电中";
            }
            else if (value.ToString() == "15")
            {
                return "充电完成";
            }
            else if (value.ToString() == "20")
            {
                return "手动、无码";
            }
            else if (value.ToString() == "21")
            {
                return "手动、有码";
            }
            else
            {
                return value.ToString();
            }
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
    
    //定义值转换器
    [ValueConversion(typeof(string), typeof(string))]
    //任务异常背景色
    public class TaskErrConvert : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value == null) return new SolidColorBrush(Colors.Transparent);

            if (int.Parse(value.ToString()) == 0)
            {
                return new SolidColorBrush(Colors.Transparent);
            }
            else
            {
                return new SolidColorBrush(Colors.Red);
            }
            //return Application.res
        }
        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
