using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Shapes;

namespace ACS
{
     public class agvModel : Shape
    {
         //int _dirction;
         //public agvModel(int dirction)
         //{
         //    _dirction = dirction;
         //}
         public agvModel()
         {
         }

         protected override Geometry DefiningGeometry
        {
            get { return GenerateMyWeirdGeometry(); }
        }

         public GeometryGroup GenerateMyWeirdGeometry()
        {
            
            int r = (int)App.radius * 2 / 3;
            StreamGeometry geom = new StreamGeometry();
            using (StreamGeometryContext gc = geom.Open())
            {
                gc.BeginFigure(new System.Windows.Point(60 + r / 2, 60 - r / 2), false, false);
                gc.ArcTo(new System.Windows.Point(60 + r / 2, 60 + r / 2), new System.Windows.Size(1, 2), 0, false, SweepDirection.Clockwise, true, true);
                gc.BeginFigure(new System.Windows.Point(60 - r / 2, 60 - r / 2), false, false);
                gc.ArcTo(new System.Windows.Point(60 - r / 2, 60 + r / 2), new System.Windows.Size(1, 2), 0, false, SweepDirection.Counterclockwise, true, true);
            }
            RectangleGeometry myRectGeometry = new RectangleGeometry();
            myRectGeometry.Rect = new Rect(60 - r / 2, 60 - r / 2, r, r);
            GeometryGroup myGeometryGroup = new GeometryGroup();
            EllipseGeometry largeEllipseGeometry = new EllipseGeometry();
            largeEllipseGeometry.Center = new System.Windows.Point(60, 60);
            largeEllipseGeometry.RadiusX = r / 2;
            largeEllipseGeometry.RadiusY = r / 2;
            //EllipseGeometry smallEllipseGeometry = new EllipseGeometry();
            //smallEllipseGeometry.Center = new System.Windows.Point(60, 60);
            //smallEllipseGeometry.RadiusX = r / 4;
            //smallEllipseGeometry.RadiusY = r / 4;           
            EllipseGeometry littleEllipseGeometry = new EllipseGeometry();
            littleEllipseGeometry.Center = new System.Windows.Point(60 + r * 5 / 8, 60);
            littleEllipseGeometry.RadiusX = r / 8;
            littleEllipseGeometry.RadiusY = r / 8;
            myGeometryGroup.Children.Add(myRectGeometry);
            myGeometryGroup.Children.Add(largeEllipseGeometry);
            //myGeometryGroup.Children.Add(smallEllipseGeometry);
            myGeometryGroup.Children.Add(littleEllipseGeometry);          
            myGeometryGroup.Children.Add(geom);
            return myGeometryGroup;
        }

        public GeometryCollection Children 
        {
            get
            {
                return GenerateMyWeirdGeometry().Children;
            }
        }

    }
}

