from tkinter import *

wins=Tk() #实例化窗口类。若import tkinter，则写成wins=tkinter.Tk() 
wins.title("tool")#设置窗口标题（或使用wins.wm_title()）
acs=Label(wins,text="agvNo")#对wins窗口添加内容为agvNo的标签
acs.pack()#将标签放到相应窗口的相应位置上
wins.mainloop()#创建窗口，让窗口循环接收下一个事件