# -*- coding:utf-8 -*-
from sqlOperation import sqlOperation
from requests import Request
class deal(object):
    '''
    处理报文
    '''

    def __init__(self,agv,sql):
        self.agv=agv
        self.sql=sqlOperation('SQL Server Native Client 11.0','127.0.0.1','sa','abc123*','ACS_MNLM')
        self.url="http://10.121.44.220:8080/ModelService/MoveBack"

    def manage(self):
        if self.agv[14] is None or len(self.agv[14])==1 or len(self.agv[14])==0:
            if not self.agv[13] is None:
                self.agv[14]=self.agv[13]
            else:
                self.agv[14]=bytearray([0,0])
        if self.agv[14][1]==0:
            self.HeartBeat(0)
        elif self.agv[14][1]==1:
            self.HeartBeat(1)
        elif self.agv[14][1]==2:
            #if self.agv[3] == 11 and self.agv[4] == 3 and (self.agv[2] in (14945,18991,14983,1847,2655)):
            #    shelfAtStation=self.sql.ExecQuery("SELECT * FROM dbo.T_Base_Shelf s LEFT JOIN dbo.T_Base_Station st ON st.strBarcode = s.strCurrentBarcode WHERE s.strCurrentBarcode<>s.strBarcode AND s.strCurrentBarcode='%s'"%self.agv[2],True)
            #    for shelf in shelfAtStation:
            #        re=Request("post",self.url,data=[shelf["strShelfNo"], shelf["strStationNo"], shelf["oriShelf"], shelf["oriShelf"]])
            self.agv[14]=self.agv[13]
        elif self.agv[14][1]==3:
            self.HeartBeat(3)
        return self.agv

    def HeartBeat(self,flag):
        actionType = 0
        data=[0 for x in range(0,33)]
        data[0]=0
        data[1]=0
        data[2]=18
        #agvno
        tmpagvno=bytes(self.agv[0],encoding="utf-8")
        for i in range(len(tmpagvno)):
            data[3+i]=tmpagvno[i]
        data[19]=self.agv[3]#自身状态
        data[20]=self.agv[4] #顶升
        #barcode
        #tmpbarcode=bytes(self.agv.strBarcode,encoding="utf-8")
        #print(self.agv.strBarcode)
        #print(int(self.agv.strBarcode))
        tmpbarcode=int(self.agv[2]).to_bytes(4,byteorder = 'little')
        data[13]=tmpbarcode[0]
        data[14]=tmpbarcode[1]
        data[15]=tmpbarcode[2]
        data[16]=tmpbarcode[3]

 
        DataReceive=bytearray(self.agv[14])
        if flag==1:
            actionType = DataReceive[7]
            data[30]=0
            #barCode1 = str(DataReceive[8:12],encoding="utf-8").replace("\x00","")
            barCode1 = int.from_bytes(DataReceive[8:12],byteorder='little')
            ypos1 = int.from_bytes(DataReceive[14:16],byteorder='little')
            xdis1 = int.from_bytes(DataReceive[16:18],byteorder='little')
            ydis1 = int.from_bytes(DataReceive[18:20],byteorder='little')
            ptype1 = DataReceive[21]
            slatype1 = DataReceive[23]

            #barCode2 = str(DataReceive[24:28],encoding="utf-8").replace("\x00","")
            barCode2 = int.from_bytes(DataReceive[24:28],byteorder='little')
            xpos2 = int.from_bytes(DataReceive[28:30],byteorder='little')
            ypos2 = int.from_bytes(DataReceive[30:32],byteorder='little')
            xdis2 = int.from_bytes(DataReceive[32:34],byteorder='little')
            ydis2 = int.from_bytes(DataReceive[34:36],byteorder='little')
            ptype2 = DataReceive[37]
            slatype2 = DataReceive[39]

            self.agv[2]=barCode2

            if self.agv[2] == 0:
               self.agv[2] = barCode1

        if flag == 1:
            self.agv[3] = 13
        elif flag == 3:
            if not self.agv[3] == 14:
                self.agv[3] = 11
        if actionType == 2:
            self.agv[4] = 3
        elif actionType == 3:
            self.agv[4] = 1
        elif actionType == 6:
            self.agv[3] = 14
        elif actionType == 7:
            self.agv[3] = 11
        #电量
        if self.agv[5] > 10000:
            self.agv[5] = 10000
        data[17]=int(self.agv[5]).to_bytes(2,byteorder = 'little')[0]
        data[18]=int(self.agv[5]).to_bytes(2,byteorder = 'little')[1]

        data[21]=self.agv[11] #list.Error
        data[19]=self.agv[3]
        data[20]=self.agv[4]

        #是否将任务号也发送回去
        DTaskNo = []
        if flag == 2 and self.agv[3] == 13:
            pass
        if flag == 3:
            DTaskNo = bytes(0)
        elif self.agv[3] == 13 and not self.agv[2] == 0:
            if flag == 0 and self.agv[12] == 0:
                DTaskNo = bytes(self.agv[12])
            elif not flag == 0:
                DTaskNo = bytes(DataReceive[3:7])
                data[30]=1
        for i in range(len(DTaskNo)):
            data[26+i]=DTaskNo[i]
        c = CRC(data, 32)
        data[31]=c

        self.agv[14] = bytearray(data)

def CRC(byt, Length):
    crc = 0
    crc = byt[0] ^ byt[1]
    for i in range(Length-1):
        crc=crc^byt[i+2]
    return crc

            
                