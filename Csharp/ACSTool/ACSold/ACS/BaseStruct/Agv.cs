using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace ACS
{
    public class Agv
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
        public string agvNo;
        public string _agvNo
        {
            get { return agvNo; }
            set
            {
                agvNo = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_agvNo"));
            }
        }

        /// <summary>
        /// 小车当前的码值
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
        /// 小车状态
        /// </summary>
        public AgvState state;
        public int _state
        {
            get { return (int)state; }
            set
            {
                state = (AgvState)value;
                OnPropertyChanged(new PropertyChangedEventArgs("_state"));
            }
        }

        /// <summary>
        /// 小车是否可用
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
        /// 小车当前电量
        /// </summary>
        public float currentCharge;
        public float _currentCharge
        {
            get { return currentCharge; }
            set
            {
                currentCharge = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_currentCharge"));
            }
        }

        /// <summary>
        /// 小车当前的顶升状态
        /// </summary>
        public HeightEnum height;
        public HeightEnum _height
        {
            get { return height; }
            set
            {
                height = value;
                OnPropertyChanged(new PropertyChangedEventArgs("_height"));
            }
        }

        /// <summary>
        /// 小车当前子任务列表
        /// </summary>
        public List<STask> sTaskList;

        public int errorMsg;

        public string areaNo;
    }
}
