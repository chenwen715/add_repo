using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Shapes;

namespace ACS.Common
{
    public class DSharp
    {
        public void CanvasInit()
        {
            App.PointList.Sort(Comparisony);
            App.maxY = App.PointList[0].y;
            //App.minY = App.pointList[App.pointList.Count - 1].y;
            App.minY = 2;
            App.PointList.Sort(Comparisonx);
            //App.minX = App.pointList[0].x;
            App.minX = 0;
            App.maxX = App.PointList[App.PointList.Count - 1].x;

            int[] csize = MoniterAreaInit();
            App.Canvas_Monit.Width = csize[0];
            App.Canvas_Monit.Height = csize[1];
        }

        public void DrawPPoint()
        {
            foreach (Point p in App.PointList)
            {
                string ptype = "";
                int pointSize = Radius(p);
                Ellipse elli = new Ellipse();
                elli.Width = pointSize;//设置点的大小
                elli.Height = pointSize;//设置点的大小，点为圆时，width和height值一样
                /*
               * D1、普通行走点；（黑）  
               * D3、充电点；（绿）
               * D4、站台点；（红）
               * D5、站台附属点；（紫）
               * D6、货架点；（黑）
               */
                switch (p.pointType)
                {
                    case PointType.D1:
                        ptype = "普通行走点";
                        elli.Fill = new SolidColorBrush(Colors.Black);
                        break;
                    case PointType.D6:
                        ptype = "货架点";
                        elli.Fill = new SolidColorBrush(Colors.Black);
                        break;
                    case PointType.D3:
                        ptype = "充电点";
                        elli.Fill = new SolidColorBrush(Colors.Green);
                        break;
                    case PointType.D4:
                        ptype = "站台附属点";
                        elli.Fill = new SolidColorBrush(Colors.Red);
                        break;
                    case PointType.D5:
                        ptype = "站台点";
                        elli.Fill = new SolidColorBrush(Colors.BlueViolet);
                        break;
                    default:
                        break;
                }
                elli.ToolTip = string.Format("码值:{0}\n坐标x:{2} y坐标:{3}\n{1}", p.barCode, ptype, p.x, p.y);//鼠标悬浮到该点上时显示
                double[] xy = DrawSharp(
                    p.x, p.y, App.GsWidth, App.GsHeight, pointSize);
                elli.SetValue(Canvas.TopProperty, (double)xy[1]);//设置点距幕布顶端的距离
                elli.SetValue(Canvas.LeftProperty, (double)xy[0]);//设置点距幕布左端的距离
                App.Canvas_Monit.Children.Add(elli);//将点添加到幕布中，显示
                App.PPSharp.Add(elli);//将点添加到地图点显示集合中
            }
        }


        #region
        public void DrawAgv()
        {
            foreach (Agv agv in App.AgvList)
            {
                agvModel am = new agvModel();
                am.Name = agv.agvNo;
                am.ToolTip = am.Name;
                agvShow(am, agv);
                //am.Stroke = new SolidColorBrush(Colors.Tan);
                am.StrokeThickness = 3;

                Point p = App.PointList.Find(a => a.barCode == agv.barcode);

                if (p != null)
                {
                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius - 4);
                    am.SetValue(Canvas.TopProperty, (double)xy[1] - App.radius / 2 - 2);
                    am.SetValue(Canvas.LeftProperty, (double)xy[0] - App.radius / 2 - 2);
                    System.Windows.Size s = am.RenderSize;
                    switch (agv.angle)
                    {
                        case 1:
                            rotateAgv(am, 0);
                            break;
                        case 2:
                            rotateAgv(am, 90);
                            break;
                        case 3:
                            rotateAgv(am, 180);
                            break;
                        case 4:
                            rotateAgv(am, 270);
                            break;
                        default:
                            rotateAgv(am, 0);
                            break;
                    }

                    //rotateAgv(am,30);
                }

                if (!agv.isEnable)
                {
                    am.Visibility = System.Windows.Visibility.Collapsed;
                }
                else
                {
                    am.Visibility = System.Windows.Visibility.Visible;
                }
                App.Canvas_Monit.Children.Add(am);
                App.AgvModelList.Add(am);
            }
        }

        public void agvShow(agvModel am, Agv Agv)
        {
            GeometryCollection amc = am.Children;
            Geometry smallcircle = amc[1];

            if (Agv.height == HeightEnum.Low)
            {
                am.Stroke = new SolidColorBrush(Colors.Tan);
                am.Fill = new SolidColorBrush(Colors.Transparent);
            }
            //else if (Agv._height == HeightEnum.Middle)
            //{
            //    Ell.Stroke = new SolidColorBrush(Colors.DarkOrange);
            //}
            else if (Agv.height == HeightEnum.High)
            {
                am.Fill = new SolidColorBrush(Colors.Tan);
            }
            if (Agv.state == (AgvState)14)
            {
                am.Stroke = new SolidColorBrush(Colors.DarkGreen);
            }
            else if (Agv.state == (AgvState)13)
            {
                am.Stroke = new SolidColorBrush(Colors.Red);
            }
            else if (Agv.state == (AgvState)11)
            {
                am.Stroke = new SolidColorBrush(Colors.Tan);
            }
        }


        public void AgvChange(Agv Agv, Point p)
        {
            App.AppDispatcher.Invoke(new Action(() =>
            {
                agvModel agvm = App.AgvModelList.Find(
                  new Predicate<agvModel>(
                      a => { return a.Name == Agv.agvNo; }));

                if (agvm != null)
                {

                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius - 4);

                    agvm.SetValue(System.Windows.Controls.Canvas.LeftProperty, (double)xy[0] - App.radius / 2 - 2);

                    agvm.SetValue(System.Windows.Controls.Canvas.TopProperty, (double)xy[1] - App.radius / 2 - 2);

                    switch (Agv.angle)
                    {
                        case 1:
                            rotateAgv(agvm, 0);
                            break;
                        case 2:
                            rotateAgv(agvm, 90);
                            break;
                        case 3:
                            rotateAgv(agvm, 180);
                            break;
                        case 4:
                            rotateAgv(agvm, 270);
                            break;
                        default:
                            rotateAgv(agvm, 0);
                            break;
                    }
                }

            }));
        }

        public void AgvShelfStatusChange(Agv Agv)
        {
            App.AppDispatcher.Invoke(new Action(() =>
            {
                agvModel agvm = App.AgvModelList.Find(
                  new Predicate<agvModel>(
                      a => { return a.Name == Agv.agvNo; }));

                if (agvm != null)
                {
                    agvShow(agvm, Agv);
                }

            }));
        }
        #endregion

        public void DrawShelf()
        {
            foreach (Shelf sf in App.ShelfList)
            {
                Rectangle re = new Rectangle();
                re.Name = sf.shelfNo;
                re.ToolTip = "货架号：" + re.Name + "\n当前码值：" + sf.currentBarcode;
                re.Width = App.radius;
                re.Height = App.radius;
                re.Fill = new SolidColorBrush(Colors.Transparent);
                re.Stroke = new SolidColorBrush(Colors.Blue);
                re.StrokeThickness = 2;
                Point p = App.PointList.Find(a => a.barCode == sf.currentBarcode);
                if (p != null)
                {
                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius);
                    re.SetValue(Canvas.TopProperty, (double)xy[1]);
                    re.SetValue(Canvas.LeftProperty, (double)xy[0]);
                }
                App.Canvas_Monit.Children.Add(re);
                App.ShelfSharp.Add(re);
            }
        }

        public int[] MoniterAreaInit()
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
        public double[] DrawSharp(int p1, int p2, int p3, int p4, int size)
        {
            int y = (App.maxY - p2) * p4 - size / 2;
            int x = (p1 - App.minX) * p3 - size / 2;
            return new double[] { x, y };
        }

        private int Comparisony(Point x, Point y)
        {
            return y.y.CompareTo(x.y);
        }

        private int Comparisonx(Point x, Point y)
        {
            return x.x.CompareTo(y.x);
        }

        public int Radius(Point p)
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

        //AGV为圆圈
        #region
        public void DrawAgvCircle()
        {
            foreach (Agv agv in App.AgvList)
            {
                Ellipse Elps = new Ellipse();
                Elps.Name = agv.agvNo;
                Elps.ToolTip = Elps.Name;
                Elps.Width = App.radius - 4;
                Elps.Height = App.radius - 4;
                agvShow(Elps, agv);
                //Elps.Fill = new SolidColorBrush(Colors.Transparent);
                //Elps.Stroke = new SolidColorBrush(Colors.Tan);
                Elps.StrokeThickness = 3;

                Point p = App.PointList.Find(a => a.barCode == agv.barcode);

                if (p != null)
                {
                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius - 4);
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
                App.Canvas_Monit.Children.Add(Elps);
                App.AgvSharp.Add(Elps);
            }
        }

        public void agvShow(Ellipse Ell, Agv Agv)
        {
            if (Agv.height == HeightEnum.Low)
            {
                Ell.Stroke = new SolidColorBrush(Colors.Tan);
                Ell.Fill = new SolidColorBrush(Colors.Transparent);
            }
            //else if (Agv._height == HeightEnum.Middle)
            //{
            //    Ell.Stroke = new SolidColorBrush(Colors.DarkOrange);
            //}
            else if (Agv.height == HeightEnum.High)
            {
                Ell.Fill = new SolidColorBrush(Colors.Tan);
            }
            if (Agv.state == (AgvState)14)
            {
                Ell.Stroke = new SolidColorBrush(Colors.DarkGreen);
            }
            else if (Agv.state == (AgvState)13)
            {
                Ell.Stroke = new SolidColorBrush(Colors.Red);
            }
            else if (Agv.state == (AgvState)11)
            {
                Ell.Stroke = new SolidColorBrush(Colors.Tan);
            }
        }

        public void AgvChange1(Agv Agv, Point p)
        {
            App.AppDispatcher.Invoke(new Action(() =>
            {
                System.Windows.Shapes.Ellipse Ell = App.AgvSharp.Find(
                  new Predicate<System.Windows.Shapes.Ellipse>(
                      a => { return a.Name == Agv.agvNo; }));

                if (Ell != null)
                {

                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius - 4);

                    Ell.SetValue(System.Windows.Controls.Canvas.LeftProperty, (double)xy[0]);

                    Ell.SetValue(System.Windows.Controls.Canvas.TopProperty, (double)xy[1]);

                }

            }));
        }

        public void AgvShelfStatusChange1(Agv Agv)
        {
            App.AppDispatcher.Invoke(new Action(() =>
            {
                System.Windows.Shapes.Ellipse Ell = App.AgvSharp.Find(
                  new Predicate<System.Windows.Shapes.Ellipse>(
                      a => { return a.Name == Agv.agvNo; }));

                if (Ell != null)
                {
                    agvShow(Ell, Agv);
                }

            }));
        }
        #endregion

        public void ShelfChange(Shelf Shelf, Point p)
        {
            App.AppDispatcher.Invoke(new Action(() =>
            {
                System.Windows.Shapes.Rectangle Rec = App.ShelfSharp.Find(
                  new Predicate<System.Windows.Shapes.Rectangle>(
                      a => { return a.Name == Shelf._shelfNo; }));

                if (Rec != null)
                {

                    double[] xy = DrawSharp(p.x, p.y, App.GsWidth, App.GsHeight, App.radius);

                    Rec.ToolTip = Shelf._shelfNo + "\n" +
                        string.Format("({0},{1})", p.x, p.y);

                    Rec.SetValue(System.Windows.Controls.Canvas.LeftProperty, (double)xy[0]);

                    Rec.SetValue(System.Windows.Controls.Canvas.TopProperty, (double)xy[1]);

                }

            }));

        }

        public void rotateAgv(agvModel am, int angle)
        {
            am.RenderTransformOrigin = new System.Windows.Point(0.6565,0.735);
            RotateTransform rt = new RotateTransform();
            rt.Angle = angle;
            TransformGroup trg = new TransformGroup();
            trg.Children.Add(rt);
            am.RenderTransform = trg;
        }

        //public void PathHide(string AgvNo)
        //{
        //    PathFigure Pfigure = null;
        //    PathGeometry pGeotry = null;

        //    Path LPath = App.PathSharp.Find(a => a.Tag.ToString() == AgvNo);
        //    if (LPath != null)
        //    {
        //        pGeotry = (PathGeometry)LPath.Data;
        //        Pfigure = pGeotry.Figures[0];
        //        Pfigure.Segments.Clear();
        //    }
        //}

        //public void DrawPath(System.Windows.Point[] arrPoints, string AgvNo)
        //{

        //    PathFigure Pfigure = null;
        //    PathGeometry pGeotry = null;
        //    Path path = null;

        //    Path LPath =
        //    App.PathSharp.Find(a => a.Tag.ToString() == AgvNo);

        //    if (LPath == null)
        //    {
        //        pGeotry = new PathGeometry();
        //        Pfigure = new PathFigure();
        //        Pfigure.IsClosed = false;
        //        path = new Path();
        //        path.Data = pGeotry;
        //        path.Tag = AgvNo;
        //        path.ToolTip = AgvNo;

        //        path.Stroke = new SolidColorBrush(Colors.LightGreen);
        //        path.StrokeThickness = 6;
        //        path.StrokeStartLineCap = PenLineCap.Flat;
        //        path.StrokeEndLineCap = PenLineCap.Triangle;
        //        path.StrokeDashArray.Add(1);

        //        pGeotry.Figures.Add(Pfigure);

        //        App.PathSharp.Add(path);

        //        App.Canvas_Monit.Children.Add(path);
        //    }

        //    else
        //    {
        //        path = LPath;
        //        pGeotry = (PathGeometry)LPath.Data;
        //        Pfigure = pGeotry.Figures[0];
        //        Pfigure.Segments.Clear();
        //    }
        //    int[] xyS = DrawPoint((int)arrPoints[0].X, (int)arrPoints[0].Y, App.GsHeight, App.GsWidth);
        //    Pfigure.StartPoint = new System.Windows.Point(xyS[0], xyS[1]);

        //    foreach (System.Windows.Point p in arrPoints)
        //    {
        //        if (p.X == 0 && p.Y == 0)
        //            break;

        //        int[] xy = DrawPoint((int)p.X, (int)p.Y, App.GsHeight, App.GsWidth);


        //        LineSegment lsegment = new LineSegment(new System.Windows.Point(xy[0], xy[1]), true);


        //        Pfigure.Segments.Add(lsegment);
        //    }

    
    }
}
