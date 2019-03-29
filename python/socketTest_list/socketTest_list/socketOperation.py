# -*- coding:utf-8 -*-
import socket
from deal import deal
import time

class socketOperation(object):
    '''
    连接服务端
    '''

    def __init__(self,ip,port,sql,agv):
        self.ip=ip
        self.port=port
        self.sql=sql
        self.agv=agv

    def clientSocket(self):
        '''
        作为客户端
        '''
        try:
            while True:
                s=socket.socket()
                s.connect((self.ip,self.port))
                #print("已连接等待接收数据")
                self.agv=deal(self.agv,self.sql).manage()
                self.agv[13]=self.agv[14]
                s.send(self.agv[14])
                #print("发送报文成功")
                recv_bytes=s.recv(1024)
                #print("接收报文成功")
                s.close()
                time.sleep(0.8)
                self.agv[14]=list(recv_bytes)
        except Exception as e:
            print("Exception:",e)

    def serverSocket(self):
        '''
        作为服务端
        '''
        s=socket.socket()
	    #host=socket.gethostname()
        host="127.0.0.1"
        port=2223
        s.bind((host,port))

        s.listen(5)

        while True:
            c,addr=s.accept()
            c.settimeout(3)
            print("连接地址为：",addr)		
            receivedata=c.recv(1024)
            #解析agvNo
            a=receivedata[3:13]
            b=str(a,encoding="utf-8").replace("\x00","")
            print(b)

	        #c.close()

if __name__=="__main__":
    soc=socketOperation("127.0.0.1",888)
    soc.clientSocket()