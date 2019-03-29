# -*- coding:utf-8 -*-
from sqlOperation import sqlOpreation
from requests import Request
class deal(object):

    def __init__(self,sql):
        #self.agv=agv
        self.sql=sqlOpreation('SQL Server Native Client 11.0','127.0.0.1','sa','abc123*','ACS_MNLM')
        self.url="http://10.121.44.220:8080/ModelService/MoveBack"

    def manage(self,agv):
        if agv.returnBytes is None or len(agv.returnBytes)==1 or len(agv.returnBytes)==0:
            if not agv.reSend is None:
                agv.returnBytes=agv.reSend
            else:
                agv.returnBytes=bytearray([0,0])
        #print(len(agv.returnBytes))
        if agv.returnBytes[1]==0:
            agv=self.HeartBeat(agv,0)
        elif agv.returnBytes[1]==1:
            agv=self.HeartBeat(agv,1)
        elif agv.returnBytes[1]==2:
            #if agv.agvState == 11 and agv.heightState == 3 and (agv.strBarcode in (14945,18991,14983,1847,2655)):
            #    shelfAtStation=self.sql.ExecQuery("SELECT * FROM dbo.T_Base_Shelf s LEFT JOIN dbo.T_Base_Station st ON st.strBarcode = s.strCurrentBarcode WHERE s.strCurrentBarcode<>s.strBarcode AND s.strCurrentBarcode='%s'"%agv.strBarcode,True)
            #    for shelf in shelfAtStation:
            #        re=Request("post",self.url,data=[shelf["strShelfNo"], shelf["strStationNo"], shelf["oriShelf"], shelf["oriShelf"]])
            agv.returnBytes=agv.reSend
        elif agv.returnBytes[1]==3:
            agv=self.HeartBeat(agv,3)
        return agv

    def HeartBeat(self,agv,flag):
        actionType = 0
        data=[0 for x in range(0,33)]
        data[0]=0
        data[1]=0
        data[2]=18
        #agvno
        tmpagvno=bytes(agv.strAgvNo,encoding="utf-8")
        for i in range(len(tmpagvno)):
            data[3+i]=tmpagvno[i]
        data[19]=agv.agvState#自身状态
        data[20]=agv.heightState #顶升
        #barcode
        tmpbarcode=int(agv.strBarcode).to_bytes(4,byteorder = 'little')
        data[13]=tmpbarcode[0]
        data[14]=tmpbarcode[1]
        data[15]=tmpbarcode[2]
        data[16]=tmpbarcode[3]

 
        DataReceive=bytearray(agv.returnBytes)
        if flag==1:
            actionType = DataReceive[7]
            data[30]=0

            barCode1 = int.from_bytes(DataReceive[8:12],byteorder='little')
            ypos1 = int.from_bytes(DataReceive[14:16],byteorder='little')
            xdis1 = int.from_bytes(DataReceive[16:18],byteorder='little')
            ydis1 = int.from_bytes(DataReceive[18:20],byteorder='little')
            ptype1 = DataReceive[21]
            slatype1 = DataReceive[23]

            barCode2 = int.from_bytes(DataReceive[24:28],byteorder='little')
            xpos2 = int.from_bytes(DataReceive[28:30],byteorder='little')
            ypos2 = int.from_bytes(DataReceive[30:32],byteorder='little')
            xdis2 = int.from_bytes(DataReceive[32:34],byteorder='little')
            ydis2 = int.from_bytes(DataReceive[34:36],byteorder='little')
            ptype2 = DataReceive[37]
            slatype2 = DataReceive[39]

            agv.strBarcode=barCode2

            if agv.strBarcode == 0:
               agv.strBarcode = barCode1

        if flag == 1:
            agv.agvState = 13
        elif flag == 3:
            if not agv.agvState == 14:
                agv.agvState = 11
        if actionType == 2:
            agv.heightState = 3
        elif actionType == 3:
            agv.heightState = 1
        elif actionType == 6:
            agv.agvState = 14
        elif actionType == 7:
            agv.agvState = 11
        #电量
        if agv.currentCharge > 10000:
            agv.currentCharge = 10000
        data[17]=int(agv.currentCharge).to_bytes(2,byteorder = 'little')[0]
        data[18]=int(agv.currentCharge).to_bytes(2,byteorder = 'little')[1]

        data[21]=agv.strAgvError #list.Error
        data[19]=agv.agvState
        data[20]=agv.heightState

        #是否将任务号也发送回去
        DTaskNo = []
        if flag == 2 and agv.agvState == 13:
            pass
        if flag == 3:
            DTaskNo = bytes(0)
        elif agv.agvState == 13 and not agv.strBarcode == 0:
            if flag == 0 and agv.intSonTaskNo == 0:
                DTaskNo = bytes(agv.intSonTaskNo)
            elif not flag == 0:
                DTaskNo = bytes(DataReceive[3:7])
                data[30]=1
        for i in range(len(DTaskNo)):
            data[26+i]=DTaskNo[i]
        c = CRC(data, 32)
        data[31]=c

        agv.returnBytes = bytearray(data)
        return agv

def CRC(byt, Length):
    crc = 0
    crc = byt[0] ^ byt[1]
    for i in range(Length-1):
        crc=crc^byt[i+2]
    return crc

            
                