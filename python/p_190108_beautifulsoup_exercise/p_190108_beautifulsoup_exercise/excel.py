import xlrd
import xlwt
import xlutils
from xlwt.Style import easyxf
from _datetime import date
import datetime
import time
from xlutils.copy import copy
class excel(object):
    """操作excel"""
    def __init__(self, filepath,data,sheetname):
        self.file=filepath
        self.data=data
        self.sn=sheetname

    #格式：[[时间, 地址, [详细地址, {品种1: [(详细品种1, 价格信息1), (详细品种2, 价格信息2)...]}]]]若无品种，则后面直接接list
    def writeexcel(self):
        try:    
            wb=xlrd.open_workbook(self.file,formatting_info=True)#加上formatting_info=True，文件格式为.xlsx时报错
            #wb=xlrd.open_workbook(self.file)
            wbc=copy(wb)
        except FileNotFoundError as e:
            #print(e)
            wbc=xlwt.Workbook(encoding="utf-8")                           
        sheet1=wbc.add_sheet(self.sn,True)
        title=["发布时间","地点-水果","地点","品种","价格"]
        i=0
        for ti in title:
            sheet1.row(0).set_cell_text(i,ti,easyxf("font: bold True;""pattern: pattern SOLID_PATTERN,fore_colour green;"))
            i+=1
        j=1
        for d in self.data:
            publisht=d[0]
            address=d[1] 
            dinfo=d[2:]    
            for m in dinfo:                         
                detailaddress=m[0]
                detalis=m[1:]
                for type in detalis:
                    dtype=""
                    price=""
                    lista=[]
                    if isinstance(type,list):
                        for a in type:
                            dtype=a[0]
                            price=a[1]
                            lista=[publisht,address,detailaddress,dtype,price]
                            self.writedata(sheet1,j,lista)
                            j+=1
                    elif isinstance(type,dict):
                        for k,v in type.items():
                            for p in v:
                                dtype=k+"："+p[0]
                                price=p[1]
                                lista=[publisht,address,detailaddress,dtype,price]
                                self.writedata(sheet1,j,lista)
                                j+=1
        wbc.save(self.file)
                        
    def writedata(self,sheet,j,lista):
        z=0
        for i in lista:
            if isinstance(i,str):
                sheet.row(j).set_cell_text(z,i)
            elif isinstance(i,datetime.date) or isinstance(i,datetime.datetime):
                sheet.row(j).set_cell_date(z,i)
            z+=1





            

