import urllib.request
import json
from bs4 import BeautifulSoup

try:
    url="http://www.baidu.com"
    #param={"wd":"python"}
    #data=urllib.parse.urlencode(param).encode("utf-8")
    a=urllib.request.urlopen(url)
    print(a.geturl())
    print(a.info())#Զ�̷���������ͷ��Ϣ
    #print(a.readline())#��ȡ��һ������
    #print(a.readlines())
    print(a.getcode())#Զ�̷���������״̬��
    #urllib.request.urlretrieve(url,"baidu.html")
    content=a.read()
    soup=BeautifulSoup(content,"lxml")
    #print(soup.prettify())
    print(soup.a)#��ǩΪa�ĵ�һ��ֵ
    print(soup.a.attrs)#��ǩΪa�ĵ�һ��ֵ�����ԣ�dict��ʽ
    print(soup.a.string)
    print(soup.select("a"))#��ǩΪa������ֵ
    #print(soup.select(".a"))#classΪa������ֵ
    #print(soup.select("#a"))#idΪa������ֵ
    #print(soup.select("p #a"))#��ǩΪp��idΪa������ֵ
    for i in soup.select("a"):
        print(i.get_text)
except Exception as e:
    print(e)
