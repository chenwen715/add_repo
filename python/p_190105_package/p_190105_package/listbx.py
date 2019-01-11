from tkinter import *

class listbx(Widget):
    """创建多列列表"""
    def __init__(self,title,content,rown,clmspan,master,**kw):
        Widget.__init__(self,master, 'listbox', kw)
        self.title=title
        self.content=content
        self.rown=rown
        self.clmspan=clmspan
        self.master=master

    def create(self):
        libList={}
        panes = PanedWindow(self.master)
        panes.grid(row=self.rown,columnspan=self.clmspan)
        for m in self.title:
            li=StringVar(value=[m]+list(a[m] for a in self.content))
            lib=Listbox(self.master,height=len(self.content)+1, listvariable=li)
            libList[lib]=[m]+list(a[m] for a in self.content)
            panes.add(lib)           
        for key,value in libList.items():
            if(value[0]=="姓名"):
                key.bind("<<ListboxSelect>>",func=self.select_adaptor(self.select,value=key,libList=libList))
        return panes  
    
    def select_adaptor(self,fun,**kwds):
            '''事件处理函数的适配器，相当于中介，那个event是从那里来的呢，我也纳闷，这也许就是python的伟大之处吧'''
            return lambda event, fun=fun, kwds=kwds: fun(event, **kwds) 

    def select(self,event,value,libList):
        pass
        #if value.curselection():
        #    idx=value.curselection()[0]
        #    for key in libList.keys():
        #        key.select_set(idx)