# -*- coding:utf-8 -*-
'''
1. 编程实现对个元素全为数字的列表，求最⼤值、最
⼩值
2. 编写程序，完成以下要求：
统计字符串中，各个字符的个数
⽐如："hello world" 字符串统计的结果为： h:1 e:1 l:3 o:2 d:1 r:1 w:1
3. 编写程序，完成以下要求：
完成⼀个路径的组装
先提示⽤户多次输⼊路径，最后显示⼀个完成的路径，⽐
如 /home/python/ftp/share
4. 编写程序，完成“名⽚管理器”项⽬
需要完成的基本功能：
1. 添加名⽚
2. 删除名⽚
3. 修改名⽚
4. 查询名⽚
5. 退出系统
程序运⾏后，除⾮选择退出系统，否则重复执⾏功能
'''
import random
from tkinter import *
from tkinter.messagebox import *
from tkinter import ttk
import os
   
def numberlist():
    '''对全是数字的列表求最大值和最小值'''
    a=[]
    i=0
    while i<20:
        #b=random.randint(1,100)
        #b=round(random.random()*100,2)#round函数取2位小数
        b="%.2f"%(random.random()*100)
        #四舍五入，注意加括号；
        #若写成"%.2f"%random.random()*100，则认为是"%.2f"%random.random()复制100遍
        a.append(b)
        i+=1
    a.sort()
    print(a)
    print(max(a))
    print(min(a))

def countC(s):
    '''统计字符串中各字符的个数'''
    count={}
    uniquec=set(a for a in s if not a.isspace())
    for i in uniquec:
        count[i]=s.count(i)
    return count

def combinePath():
    '''拼接多次输入为路径'''
    pathList=[""]
    while True:
        a=input("请输入路径，若已完成，则输入1：")
        if a.strip()=="1":
            break
        pathList.append(a)
    return "/".join(pathList)
    
def manage():
    '''名片管理器系统'''
    mpList=[]
    try:
        with open("名片信息.txt",mode="r",encoding="utf-8") as f:
            for line in f:
                line=line[:line.rfind("\\n")]               
                if line and line.strip()!="":
                    info={}
                    info["姓名"]=line.split(" ")[0]
                    info["手机号"]=line.split(" ")[1]
                    info["地址"]=line.split(" ")[2]
                    mpList.append(info)
    except FileNotFoundError as e:
        with open("名片信息.txt",mode="w",encoding="utf-8") as f:
            pass
    t=Tk()
    t.title("名片管理器")
    t.geometry("%dx%d%+d%+d"%(400, 260, 600, 300))
               
    def addContent():
        #将窗口从屏幕上移除（并没有销毁）,需要重新显示窗口，使用deiconify()方法
        t.withdraw()
        addF=Toplevel()
        addF.title("添加名片")
        addF.attributes("-topmost",True)
        Label(addF,text="姓名：").grid(row=0)
        Label(addF,text="手机号：").grid(row=1)
        Label(addF,text="地址：").grid(row=2)
        name=Entry(addF)
        name.grid(row=0,column=1)
        phoneNumber=Entry(addF)
        phoneNumber.grid(row=1,column=1)
        address=Entry(addF)
        address.grid(row=2,column=1)
        def commitInfo():
            if name.get().strip()=="":
                showinfo(message="姓名不能为空")
                return
            elif phoneNumber.get().strip()=="":
                showinfo(message="电话号码不能为空")
                return
            elif address.get().strip()=="":
                showinfo(message="地址不能为空")
                return
            newInfo={}
            newInfo["姓名"]=name.get()
            newInfo["手机号"]=phoneNumber.get()
            newInfo["地址"]=address.get()
            mpList.append(newInfo)
            showinfo(message="提交成功\n若无需再提交内容，可点击关闭")
            name.delete(0,END)
            phoneNumber.delete(0,END)
            address.delete(0,END)
        def closeW():
            addF.destroy()
            t.deiconify()
            #print(mpList)
        closeButton=Button(addF,text="关闭",command=closeW)
        closeButton.grid(row=4,column=0)
        commitButton=Button(addF,text="提交",command=commitInfo)
        commitButton.grid(row=4,column=1)       
    def deleteContent():
        deleteF=queryContent()
        deleteF.title("删除名片")
        def delt():
            pass
        delbutton=Button(deleteF,text="删除",command=delt)
        delbutton.grid(row=1,column=3)
        
    def modifyContent():
        modifyF=queryContent()
        modifyF.title("修改名片")
        def mdfy():
            pass
        modifybutton=Button(modifyF,text="修改",command=mdfy)
        modifybutton.grid(row=1,column=3)
        
    def queryContent():
        queryF=Toplevel()
        contenttitle=("姓名","手机号","地址")
        key=contenttitle[0]
        queryF.title("查询名片")
        queryF.attributes("-topmost",True)
        
        Label(queryF,text="请输入查询内容：").grid(row=0)

        queryCon=Entry(queryF)
        queryCon.grid(row=0,column=2)
        
        def go(*args): #处理事件，*args表示可变参数
            #key=selectType.get()
            queryCon.delete(0,END)
            #print(key)
                       
        selectType=ttk.Combobox(queryF,width=6)
        selectType["values"]=contenttitle
        selectType.current(0)
        selectType.bind("<<ComboboxSelected>>",go)
        selectType.grid(row=0,column=1)
        
        
        def queryC():
            findContent=[]
            if queryCon.get().strip()=="":
                #showinfo(message="请输入查询内容")
                #return
                findContent= mpList      
            for i in mpList:
                if queryCon.get().strip() in i[selectType.get()]:
                    findContent.append(i)
            if not findContent:
                Label(queryF,text="未查询到相关内容").grid(row=2,columnspan=4)
            else:
                panes = PanedWindow(queryF)
                panes.grid(row=2,columnspan=4)
                for m in contenttitle:
                    li=StringVar(value=[m]+list(a[m] for a in findContent))
                    lib=Listbox(queryF,height=len(findContent)+1, listvariable=li)
                    panes.add(lib)                            
        clickbutton=Button(queryF,text="查询",command=queryC)
        clickbutton.grid(row=0,column=3)
        return queryF
        
    def exitSystem():
        with open("名片信息.txt",mode="w",encoding="utf-8") as f:
            for i in mpList:
                f.write(" ".join(i.values())+"\n")
        t.destroy()
        
    addButton=Button(t,text="添加名片",command=addContent)
    deleteButton=Button(t,text="删除名片",command=deleteContent)
    modifyButton=Button(t,text="修改名片",command=modifyContent)
    queryButton=Button(t,text="查询名片",command=queryContent)
    exitButton=Button(t,text="退出系统",command=exitSystem)
    addButton.pack(pady=10)
    deleteButton.pack(pady=10)
    modifyButton.pack(pady=10)
    queryButton.pack(pady=10)
    exitButton.pack(pady=10)
    t.mainloop()


    
    
    
if __name__=="__main__":
    #作业1
    #numberlist()
    #作业2
    #s="hello world"
    #print(countC(s))
    #作业3
    #print(combinePath())
    manage()
