import requests
import time
import json
from CFormat import CFormat

url="http://imgsrc.baidu.com/baike/abpic/item/00e93901213fb80ee7ed81df3bd12f2eb93894fe.jpg"
req=requests.request("get",url)
#print(dir(req))
#print(req.status_code)
#print(req.url)
#print(req.content)
entry={}
entry["title"]="无双"
entry["description"]="《无双》是由庄文强执导的犯罪动作电影，由周润发、郭富城、张静初、冯文娟领衔主演，廖启智、周家怡、王耀庆联合主演，于2018年9月30日在中…"
entry["image"]=req.content
entry["createtime"]=time.localtime()
#print(entry["createtime"])
#print(entry)

#with open("post.jpg",mode="wb") as f:
#    f.write(entry["image"])
#with open("film.json",mode="w",encoding="utf-8") as f:
#    json.dump(entry,f,default=CFormat.to_json)


#entry1={}
#with open("film.json",mode="r",encoding="utf-8") as f:
#    entry1=json.load(f,object_hook=CFormat.from_json)
#print(entry1==entry)
#print(entry1)



