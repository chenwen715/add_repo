# -*- coding:utf-8 -*-
from sqlOperation import sqlOperation
from threading import Thread
from socketOperation import socketOperation

class socketTest(object):

    def __init__(self):
        self.agvlist=[]
        self.sql=sqlOperation('SQL Server Native Client 11.0','127.0.0.1','sa','abc123*','ACS_MNLM')
        self.serverIP="127.0.0.1"
        self.serverPort=888
        self.Init()

    def Init(self):
        #[ 'strAgvNo', 'agvAreaType', 'strBarcode', 'agvState', 'heightState', 'currentCharge', 
        #'strChargeStation', 'isEnable', 'isCarry', 'agvHeart', 'agvBground', 'strAgvError', 'intSonTaskNo','reSend','returnBytes']
        agv_table=self.sql.ExecQuery('''SELECT agv.*,son.intSonTaskNo FROM dbo.T_Base_Agv agv 
LEFT JOIN dbo.T_Task Task ON agv.strAgvNo=Task.strTaskAgv
LEFT JOIN dbo.T_SonTask son ON son.strTaskNo = Task.strTaskNo AND son.sonTaskState>4''')
        self.agvlist=[list(x[1:6])+[x[6]*100]+list(x[7:])+[None,None] for x in agv_table if not(x[6]==0)]
        self.agvlist=[x[:2]+[int(x[2])]+x[3:11]+[0]+x[12:] for x in self.agvlist if x[11]=='']
        self.agvlist=[x[:3]+[11]+x[4:] for x in self.agvlist if x[12]==None]

    def start(self):
        for agv in self.agvlist:
            if agv[7]==1:
                 t =Thread(target=self.action,name=agv[0],args=(agv,))
                 t.start()

    def action(self,arg):
        socket=socketOperation(self.serverIP,self.serverPort,self.sql,arg)
        socket.clientSocket()



if __name__=="__main__":
    a=socketTest()
    #print(a.agvlist)
    ready=input("请确认服务端已开启，若开启则输入y:")
    if ready=="y":
        a.start()
   




