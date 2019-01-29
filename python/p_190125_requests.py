import requests
import json
from bs4 import BeautifulSoup

url="http://127.0.0.1:8000/index"
data={"username":123,"password":122}
res=requests.get(url)
bs=BeautifulSoup(res.text,"lxml")
for inputs in bs.select("input"):
    if inputs.attrs['type']=="hidden":
        name=inputs.attrs['name']
        value=inputs.attrs['value']
        data[name]=value
        break
suburl=bs.select("form")[0].attrs['action']
posturl=url.rsplit('/',1)[0]+suburl
#print(posturl)
#print(data)
resp=requests.request("post",url=posturl,data=data)
print(resp.text)#同resp.json()

#print(json.dumps(resp.text,indent=2,sort_keys=True))
#indent默认为None，所有数据写在一行；indent为2，则字典按顺序转行写，每个级别前空2格
#sort_keys按key值排序
