from bs4 import BeautifulSoup
import requests
from selenium import webdriver
from fake_useragent import UserAgent
import re
import threading
import _thread
from excel import excel
import time

def operateWeb():   
    browser=webdriver.Chrome()
    browser.get("http://www.pingguo7.com/")

def getHtml(url):
    '''
    网络连接失败时循环获取页面html信息直至成功为止
    params:
    url:当前网页
    返回：网页HTML数据
    '''
    flag=True
    try:
         a=getHtml1(url)
         flag=False
         return a
    except ConnectionError as ex:
        print(ex)
        while flag:
            time.sleep(1)
            getHtml(url)

def getHtml1(url):
    '''
    获取页面html信息并转换为BeautifulSoup格式
    params:
    url:当前网页
    返回：网页HTML数据
    '''
    ua=UserAgent().random
    headers={"User-Agent":ua}
    a=requests.get(url,headers=headers)
    indexpage=BeautifulSoup(a.text,"lxml")
    return indexpage

def getUrlByElement(url,selector,attr):
    '''
    根据元素获取单个url
    params:
    url:当前网页
    selector:css选择器
    attr:属性
    返回：获取的url
    '''
    html=getHtml(url)
    href=html.select(selector)[0].attrs[attr]
    return href

def getTextByElement(webcontent,selector):
    '''
    根据元素获取文本内容
    params:
    webcontent:当前网页
    selector:css选择器
    返回：获取的文本内容
    '''
    tex=webcontent.select(selector)[0].text
    move = dict.fromkeys((ord(c) for c in u"\xa0"))#去除内容中的\xa0
    te = tex.translate(move)
    return te
    
def getUrlsByElement(url,selector,attr,startno=0):
    '''
    根据元素获取多个url
    params:
    url:当前网页
    selector:css选择器
    attr:属性
    startno:截取文字起始位置
    返回：获取的url字典
    '''
    Urls={}
    html=getHtml(url)
    href=html.select(selector)
    for i in href:
        Urls[i.text[startno:]]=i.a.attrs[attr]
    return Urls

def main():
    priceurl=getUrlByElement("http://www.pingguo7.com",".id24 > a","href")
    moreurls=getUrlsByElement(priceurl,".jg-list-t","href",4)
    for key,value in moreurls.items():
        if "价格" in key and ("批发" not in key):
            #t=threading.Thread(target=getPrice,name=key,args=(value,".td-lm-list li","href"))
            #t.start()
            getPrice(value,".td-lm-list li","href",key)

def getPrice(value,selector,attr,sheetname):
    listall=[]
    priceurls=getUrlsByElement(value,selector,attr)
    for h in priceurls.values():
        #测试用
        #h="http://www.pingguo7.com/jg/show-htm-itemid-27731.html"
        web=getHtml(h)
        list=[]
        addr=re.findall("日(.+?)价格", getTextByElement(web,".td-timu"))[0]
        publishtime=re.search("(\d{4}-\d{2}-\d{2} \d{2}:\d{2})", getTextByElement(web,".td-time"))[0]
        list.append(publishtime)#发布时间
        list.append(addr)#地点
        content=getTextByElement(getHtml(h),"#content")
        #print(content)
        #sellers=re.findall("({0}.+?)：\n+(\w*[\s\S]+?)推".format(addr[-2:]),content) 
        sellers=re.findall("(.+?)\s*[：:]\s*\r*\n+(\w*[\s\S]+?)推荐经纪人：",content)   
        #print(sellers[0][1])        
        for seller in sellers:
            ss=[]#卖家
            ss.append(seller[0])#详细地址
            ac=re.findall("(.*?)：?\r*\n+([\s\S]*)",seller[1])
            for ac1 in ac:
                dd=[]
                dictt={}
                if "：" in ac1[0].strip():
                    ss.append(re.findall("([^\s].+?)：(\d+.+?)。",ac1[0]))
                    continue
                else:
                    #ss.append(ac1[0].strip())                              
                    details=re.findall("([^\s].+?)：(\d+.+?)。",ac1[1])
                    for s in details:                    
                        dd.append(s)
                    dictt[ac1[0].strip()]=dd
                ss.append(dictt)           
            list.append(ss)        
        listall.append(list)
    a=excel("价格.xls",listall,sheetname)
    a.writeexcel()
    #break
    #return listall
    #格式：[[时间, 地址, [详细地址, {品种1: [(详细品种1, 价格信息1), (详细品种2, 价格信息2)...]}]]]若无品种，则后面直接接list



if __name__=="__main__":
    print("start")
    main()   
    #print(getPrice("http://www.pingguo7.com/jg/list-53.html",".td-lm-list li","href"))
    print("end")