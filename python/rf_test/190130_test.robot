***Setting***
#用于引用Library，若当前没有引用，默认为空
Library  RequestsLibrary
#下载的robotframework-requests库
Library  Collections
#Collections用于操作字典
***Test Cases***
#用于编写测试用例
testcase_1
#顶格写，表示用例名称
    #log    robot framework
    #log为testcase_1 的第一条语句，为打印关键字，相当于Python的print()，间距为4个空格
    #后面为打印的字符串，关键字与打印内容之间间距为4个空格
    ${input}=  Create Dictionary  username=jjacs  password=jjacs
    #创建一个字典变量，并且赋值，多个键值对之间间距为4个空格
    Create Session  ACS  http://172.16.18.63:99
    #创建一个基础url
    ${r}=  post Request  ACS  /login/index/  params=${input}
    #发送post请求
    #log  ${r.status_code}
    should be equal as strings  ${r.status_code}  200
    #后面两个值转换为string后一致则通过
    #log  ${r.json()}
    ${result_dict}  set variable  ${r.json()}
    #set variable将后面的值赋值给前面
    ${status}  get from dictionary  ${result_dict}  Status
    #从result_dict中获取key为Status的值赋给status
    ${sta}  evaluate  bool(True)
    #evaluate将True字符串转换为boolean格式并赋值给sta
    should be equal  ${status}  ${sta}
    ${msg}  get from dictionary  ${result_dict}  Message
    should be equal  ${msg}  操作成功
