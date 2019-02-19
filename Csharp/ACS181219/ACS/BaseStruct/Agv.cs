using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace ACS
{
    public class Agv :INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        private void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }
        /// <summary>
        /// 小车编号
        /// </summary>
        private string _agvNo;
        public string agvNo
        {
            get { return _agvNo; }
            set
            {
                if (_agvNo != value)
                {
                    _agvNo = value;
                    OnPropertyChanged(new PropertyChangedEventArgs("agvNo"));
               }
                
            }
        }

        /// <summary>
        /// 小车当前的码值
        /// </summary>
        private string _barcode;
        public string barcode
        {
            get { return _barcode; }
            set
            {
                _barcode = value;
                OnPropertyChanged(new PropertyChangedEventArgs("barcode"));
            }
        }

        /// <summary>
        /// 小车需要重建路径的需求度，值越大需求越高
        /// </summary>
        public int RePathLevel;
        /// <summary>
        /// 小车需要重建路径的时刻
        /// </summary>
        public DateTime drepath;
        /// <summary>
        /// 小车状态
        /// </summary>
        private AgvState _state;
        public AgvState state
        {
            get { return _state; }
            set
            {
                _state = value;
                OnPropertyChanged(new PropertyChangedEventArgs("state"));
            }
        }

        /// <summary>
        /// 小车是否可用
        /// </summary>
        private bool _isEnable;
        public bool isEnable
        {
            get { return _isEnable; }
            set
            {
                _isEnable = value;
                OnPropertyChanged(new PropertyChangedEventArgs("isEnable"));
            }
        }

        /// <summary>
        /// 小车当前电量
        /// </summary>
        private float _currentCharge;
        public float currentCharge
        {
            get { return _currentCharge; }
            set
            {
                _currentCharge = value;
                OnPropertyChanged(new PropertyChangedEventArgs("currentCharge"));
            }
        }

        /// <summary>
        /// 小车当前的顶升状态
        /// </summary>
        private HeightEnum _height;
        public HeightEnum height
        {
            get { return _height; }
            set
            {
                _height = value;
                OnPropertyChanged(new PropertyChangedEventArgs("height"));
            }
        }

        /// <summary>
        /// 小车当前子任务列表
        /// </summary>
        public List<STask> sTaskList;

        public int errorMsg;

        public string areaNo;

        private int _angle;
        public int angle
        {
            get { return _angle; }
            set
            {
                _angle = value;
                OnPropertyChanged(new PropertyChangedEventArgs("angle"));
            }
        }
    }
}
