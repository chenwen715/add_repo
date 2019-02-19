using System;

namespace ACS
{
    public class PathPoint : IComparable
    {
        public int SID;

        /// <summary>
        /// 路径点序号
        /// </summary>
        public int serialNo;
        
        public Point point;

        public int CompareTo(object obj)
        {
            PathPoint p = obj as PathPoint;
            if (p == null)
                throw new NotImplementedException();
            return serialNo.CompareTo(p.serialNo);
        }
    }
}
