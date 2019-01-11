import urllib.request
import json
from bs4 import BeautifulSoup

try:
    url="http://www.baidu.com"
    #param={"wd":"python"}
    #data=urllib.parse.urlencode(param).encode("utf-8")
    a=urllib.request.urlopen(url)
    print(a.geturl())
    print(a.info())#远程服务器返回头信息
    #print(a.readline())#读取第一行数据
    #print(a.readlines())
    print(a.getcode())#远程服务器返回状态码
    #urllib.request.urlretrieve(url,"baidu.html")
    content=a.read()
    soup=BeautifulSoup(content,"lxml")
    #print(soup.prettify())
    print(soup.a)#标签为a的第一个值
    print(soup.a.attrs)#标签为a的第一个值的属性，dict形式
    print(soup.a.string)
    print(soup.select("a"))#标签为a的所有值
    #print(soup.select(".a"))#class为a的所有值
    #print(soup.select("#a"))#id为a的所有值
    #print(soup.select("p #a"))#标签为p，id为a的所有值
    for i in soup.select("a"):
        print(i.get_text)
except Exception as e:
    print(e)
