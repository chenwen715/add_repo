import os
import glob
import time
import re
from urllib import parse
print(os.getcwd())
b=os.stat(os.getcwd())#获取当前路径的元信息
print(type(b))
#print(dir(b))
#print(time.localtime(b.st_ctime))
print(b)
os.chdir("C:/HH")#切换路径
os.chdir("D:/learn")#带盘符
os.chdir("/learn")#不带盘符
print(os.getcwd())#获取当前路径
print(os.path.join("q","b","1"))#拼接路径
print(os.path.expanduser("~"))#获取用户home所在路径的完整路径
a=glob.glob("*")#罗列当前路径下的所有文件
for i in a:
	print(os.path.realpath(i))#获取文件的绝对路径
	#print(os.path.join(os.getcwd(),i))#效果等效于上一句，但上一句更简洁
	#print(os.path.realpath(i)==os.path.join(os.getcwd(),i))#检验上两句效果是否一致
d="os.stat_result(st_mode=16895, st_ino=15481123719189688, st_dev=45926034, st_nlink=1, st_uid=0, st_gid=0, st_size=4096, st_atime=1545369236, st_mtime=1545369236, st_ctime=1545359740)"
r=re.compile("[(\s*](st_\w+?)=(\d+?)[),]")
e=r.findall(d)
print(type(e))
f={g[0]:int(g[1]) for g in e}
print(f)
print(type(f))
h={key:v for key,v in f.items() if "time" in key}#用if进行过滤
print(h)
j={v:k for k,v in h.items()}#交换键-值，键有重复的值任选其一
print(j)
query = 'user=pilgrim&database=master&password=PapayaWhip'
print(parse.parse_qs(query))#专用于解析url
dic={i.split("=")[0]:i.split("=")[1] for i in query.split("&")}#作用同上一行函数，但实际应用可能有问题，所以解析URL使用上一行的函数
print(dic)
ss='A02_003'
by=bytes(ss,"utf-8")
bb=ss.encode("utf-8")
print(bb)
print(len(bb))
ba=bytearray(10)
for bbb in bb:
	print(bbb)
	print(type(bbb))
	ba[bb.index(bbb)]=bbb
print(ba)

bbc=6512
bf=bbc.to_bytes(2,'big')
print(bf)

