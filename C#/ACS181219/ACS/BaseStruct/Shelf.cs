

using System.ComponentModel;
namespace ACS
{
    public class Shelf : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        private void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }
        /// <summary>
        /// 货架编号
        /// </summary>
        public string shelfNo;
        public string _shelfNo
        {
            get { return shelfNo; }
            set
            {
                shelfNo = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_shelfNo"));
            }
        }
        /// <summary>
        /// 货架区域
        /// </summary>
        public string areaNo;
        public string _areaNo
        {
            get { return areaNo; }
            set
            {
                areaNo = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_areaNo"));
            }
        }
        
        /// <summary>
        /// 货架码值
        /// </summary>
        public string barcode;
        public string _barcode
        {
            get { return barcode; }
            set
            {
                barcode = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_barcode"));
            }
        }
        
        /// <summary>
        /// 货架当前码值
        /// </summary>
        public string currentBarcode;
        public string _currentBarcode
        {
            get { return currentBarcode; }
            set
            {
                currentBarcode = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_currentBarcode"));
            }
        }
        
        /// <summary>
        /// 货架方向
        /// </summary>
        public string shelfDirection;
        public string _shelfDirection
        {
            get { return shelfDirection; }
            set
            {
                shelfDirection = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_shelfDirection"));
            }
        }

        /// <summary>
        /// 货架是否可用
        /// </summary>
        public bool isEnable;
        public bool _isEnable
        {
            get { return isEnable; }
            set
            {
                isEnable = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_isEnable"));
            }
        }
        
        /// <summary>
        /// 货架是否被任务锁
        /// </summary>
        public bool isLocked;
        public bool _isLocked
        {
            get { return isLocked; }
            set
            {
                isLocked = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_isLocked"));
            }
        }
    }
}
