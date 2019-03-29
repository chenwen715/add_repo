# -*- coding:utf-8 -*-
from random import Random

class agvclass(object):
    '''
    AGV类
    注释中为方法一，直接赋值；
    下面为方法二，先通过字典生成所有变量，之后对需要处理的数据进行处理
    '''
    def __init__(self, kwargs):
        #self.strAgvNo=kwargs["strAgvNo"]
        #self.agvAreaType=kwargs["agvAreaType"]
        #self.strBarcode=int(kwargs["strBarcode"])
        #self.agvState=kwargs["agvState"]
        #self.heightState=kwargs["heightState"]
        #if kwargs["currentCharge"]>0:
        #    self.currentCharge=int(kwargs["currentCharge"]*100)
        #else:
        #    self.currentCharge=Random.randint(8500,9000)
        #self.strChargeStation=kwargs["strChargeStation"]
        #self.isEnable=kwargs["isEnable"]
        #self.isCarry=kwargs["isCarry"]
        #self.agvHeart=kwargs["agvHeart"]
        #self.agvBground=kwargs["agvBground"]
        #if kwargs["strAgvError"]=='':
        #    self.strAgvError=0
        #else:
        #    self.strAgvError=int(kwargs["strAgvError"])
        #self.intSonTaskNo=kwargs["intSonTaskNo"]
        #if self.intSonTaskNo==None:
        #   self.agvState=11
        #self.reSend=None
        #self.returnBytes=None

        self.dic=kwargs
        self.generateClass()
        if self.currentCharge>0:
            self.currentCharge=self.currentCharge*100
        else:
            self.currentCharge=Random.randint(8500,9000)
        if self.strAgvError=='':
            self.strAgvError=0
        if self.intSonTaskNo==None:
            self.agvState=11
        self.reSend=None
        self.returnBytes=None
      
    def generateClass(self):
        '''
        将字典转换为变量名（key）=变量值（value）的格式
        '''
        for i in self.dic.items():
           exec('self.{0} = {1}'.format(i[0], 'i[1]'))