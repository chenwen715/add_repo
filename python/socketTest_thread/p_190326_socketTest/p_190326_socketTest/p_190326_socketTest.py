# -*- coding:utf-8 -*-
from sqlOperation import sqlOpreation
from threading import Thread
from socketOperation import socketOperation
from agvclass import agvclass
import _thread

class socketTest(object):

    def __init__(self):
        self.agvlist=[]
        self.sql=sqlOpreation('SQL Server Native Client 11.0','127.0.0.1','sa','abc123*','ACS_MNLM')
        self.serverIP="127.0.0.1"
        self.serverPort=888
        self.Init()

    def Init(self):
        #[ 'strAgvNo', 'agvAreaType', 'strBarcode', 'agvState', 'heightState', 'currentCharge', 
        #'strChargeStation', 'isEnable', 'isCarry', 'agvHeart', 'agvBground', 'strAgvError', 'intSonTaskNo','reSend','returnBytes']
        agv_table=self.sql.ExecQuery('''SELECT agv.*,son.intSonTaskNo FROM dbo.T_Base_Agv agv 
LEFT JOIN dbo.T_Task Task ON agv.strAgvNo=Task.strTaskAgv
LEFT JOIN dbo.T_SonTask son ON son.strTaskNo = Task.strTaskNo AND son.sonTaskState>4''',True)
        self.agvlist=[agvclass(x) for x in agv_table]

    def start(self):
        for agv in self.agvlist:
            if agv.isEnable==1:
                 t =Thread(target=self.action,name=agv.strAgvNo,args=(agv,))
                 t.start()

    def action(self,arg):
        socket=socketOperation(self.serverIP,self.serverPort,self.sql,arg)
        socket.clientSocket()



if __name__=="__main__":
    a=socketTest()
    #print(a.agvlist)
    ready=input("请确认服务端已开启，若开启则输入y:")
    if ready.lower()=="y":
        a.start()
   




