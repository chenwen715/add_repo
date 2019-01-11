# -*- encoding:utf-8 -*-
import keyword
print("你好","hello")
#查看所有关键字
#print(keyword.kwlist)
#print("=".rjust(40,"="))

print("{4}\n姓名：{0}\nQQ：{1}\n手机号：{2}\n公司地址：{3}\n{4}".format("dongge","123456","13182677980","北京海淀区","".rjust(40,"=")))


#name=input("请输入你的姓名：")
#qq=input("请输入你的QQ号：")
#phoneNumber=input("请输入你的手机号：")
#companyAddress=input("请输入你的公司地址：")
#print('''\n你的名片为：
#{4:=<40}
#姓名：{0}
#QQ：{1}
#手机号：{2}
#公司地址：{3}
#{4:=<40}'''.format(name,qq,phoneNumber,companyAddress,""))

#char转数字
print(ord("a"))
#数字转char
print(chr(65))
#10进制转16进制
print(hex(17))
#10进制转8进制
print(oct(17))

