# -*- coding:utf-8 -*-
import socket
from deal import deal
import time

class socketOperation(object):

    def __init__(self,ip,port,sql,agv):
        self.ip=ip
        self.port=port
        self.sql=sql
        self.agv=agv

    def clientSocket(self):
        try:
            while True:
                s=socket.socket()
                s.connect((self.ip,self.port))
                #print("已连接等待接收数据")
                self.agv=deal(self.sql).manage(self.agv)
                self.agv.reSend=self.agv.returnBytes
                s.send(self.agv.returnBytes)
                #print("发送报文成功")
                recv_bytes=s.recv(1024)
                #print("接收报文成功")
                s.close()
                self.agv.returnBytes=list(recv_bytes)
                time.sleep(0.5)
        except Exception as e:
            print("Exception:",e)


if __name__=="__main__":
    soc=socketOperation("127.0.0.1",888)
    soc.clientSocket()