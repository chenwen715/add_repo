using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace statistics
{
    class task
    {
        /// <summary>
        /// 任务类型：4手动，5充电，6取消充电，7回家，8出库，9回库
        /// </summary>
        public int taskType { get; set; }

        /// <summary>
        /// 货架号
        /// </summary>
        public string shelfNo { get; set; }

        /// <summary>
        /// 站台号
        /// </summary>
        public string stationNo { get; set; }

        /// <summary>
        /// 任务建立时间
        /// </summary>
        public DateTime setupTime { get; set; }

        /// <summary>
        /// 小车号
        /// </summary>
        public string agvNo { get; set; }

        /// <summary>
        /// 任务开始时间
        /// </summary>
        public DateTime startTime { get; set; }

        /// <summary>
        /// 任务结束时间
        /// </summary>
        public DateTime endTime { get; set; }

        /// <summary>
        /// 数据是否有效
        /// </summary>
        public bool isEnable { get; set; }

        /// <summary>
        /// 单条任务时间，充电相关：结束时间-建立时间；货架相关：结束时间-开始时间
        /// </summary>
        public TimeSpan singleTaskTime { get; set; }

        /// <summary>
        /// 充电所用时间：取消充电任务开始时间-充电任务结束时间
        /// </summary>
        public TimeSpan chargePeriod { get; set; }

        /// <summary>
        /// 充电任务消耗总时间
        /// </summary>
        public TimeSpan chargeTotalTime { get; set; }

        /// <summary>
        /// 货架任务消耗总时间
        /// </summary>
        public TimeSpan shelfTotalTime { get; set; }

        /// <summary>
        /// 货架在用时间
        /// </summary>
        public TimeSpan shelfWorkTime { get; set; }

        /// <summary>
        /// 货架在工作台时间（=人工按按钮建立任务时间+建立路径时间）
        /// </summary>
        public TimeSpan shelfAtStationTime { get; set; }

        /// <summary>
        /// 建立路径时间
        /// </summary>
        public TimeSpan createPathTime { get; set; }

        /// <summary>
        /// 货架任务间隔时间
        /// </summary>
        private TimeSpan _ts = TimeSpan.Parse("23:59:59");
        public TimeSpan intervalTime 
        {
            get { return _ts; }
            set { _ts = value; }
        }
           

        /// <summary>
        /// 数据可能有误（连续充电任务）
        /// </summary>
        public bool possibleError { get; set; }

        private TimeSpan _ts1 = TimeSpan.Parse("23:59:59");
        /// <summary>
        /// 补车时间
        /// </summary>
        public TimeSpan addAGVTime
        {
            get { return _ts1; }
            set { _ts1 = value; }
        }

        private TimeSpan _ts2 = TimeSpan.Parse("23:59:59");
        /// <summary>
        /// 出库任务完成间隔时间
        /// </summary>
        public TimeSpan shelfOutFinishIntervalTime
        {
            get { return _ts2; }
            set { _ts2 = value; }
        }
    }
}
