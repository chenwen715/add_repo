import requests

url="https://sec-m.ctrip.com/restapi/soa2/10220/json/activitySearch"
headers={}
headers["cookie"]='Union=SID=155952&AllianceID=4897&OUID=baidu81|index|||; Session=SmartLinkCode=U155952&SmartLinkKeyWord=&SmartLinkQuary=&SmartLinkHost=&SmartLinkLanguage=zh; _abtest_userid=024946ad-ea47-4fe5-9099-fa9e1bfa6c80; _RF1=222.92.108.46; _RSG=r747ijbt9BFbKDkte_eGY9; _RDG=289d896b8e98d92bd008ec434d2e5f1b02; _RGUID=f2c9de5b-6c1c-41f5-9890-a3fa37b8d525; gad_city=cd7492b6028e9f80795de5e25ac40941; traceExt=campaign=CHNbaidu81&adid=index; MKT_Pagesource=PC; _ga=GA1.2.1458814360.1548747673; _gid=GA1.2.388455850.1548747673; DomesticUserHostCity=SHA%7c%c9%cf%ba%a3; appFloatCnt=1; FD_SearchHistorty={"type":"D","data":"D%24%u4E0A%u6D77%28SHA%29%24SHA%242019-01-29%24%u5317%u4EAC%28BJS%29%24BJS%242019-02-04"}; _bfa=1.1548747669399.2v8zea.1.1548747669399.1548747669399.1.3; _bfs=1.3; Mkt_UnionRecord=%5B%7B%22aid%22%3A%224897%22%2C%22timestamp%22%3A1548747729201%7D%5D; __zpspc=9.1.1548747672.1548747729.3%231%7Cbaidu%7Ccpc%7Cbaidu81%7C%7C%23; _jzqco=%7C%7C%7C%7C1548747673269%7C1.218622919.1548747672685.1548747704218.1548747729212.1548747704218.1548747729212.undefined.0.0.3.3; _bfi=p1%3D10320673304%26p2%3D101023%26v1%3D3%26v2%3D2'
resp=requests.request("POST",url,headers=headers)
print(resp.text)
