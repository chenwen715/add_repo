# -*- coding:utf-8 -*-
'''
a=input("请输入刀子长度:")
if int(a)<=10:
    print("ok")
else:
    print("forbidden")
'''

'''
cardAccount=input("公交卡余额：")
if int(cardAccount)>2:
    hasSeat=input("是否有座，1为有座，其余为无座：")
    print("请上车")
    if int(hasSeat)==1:
        print("请坐下")
    else:
        print("请站着")
else:
    print("余额不足，不能上车")
'''

'''
import random
dct={"0":"石头","1":"剪刀","2":"布"}
player=input("请输入石头（0），剪刀（1），布（2）：")
player=int(player)
computer=random.randint(0,2)
print(computer)
if player==computer:
    print("你出了{0}，电脑出了{1}，好巧，打平了".format(dct[str(player)],dct[str(computer)]))
elif (player==0 and computer==1) or (player==1 and computer==2) or \
(player==2 and computer==0):
    #加\表示换行
    print("你出了{0}，电脑出了{1}，恭喜你赢了".format(dct[str(player)],dct[str(computer)]))
else:
    print("你出了{0}，电脑出了{1}，不好意思你输啦".format(dct[str(player)],dct[str(computer)]))
'''

'''
sum=0
for i in (a for a in range(101) if a%2==0):
    sum+=i
print(sum)
'''

'''
count=5
i=1
while i<=count:
    j=1
    while j<=i:
        print("*",end="\t")
        j+=1
    i+=1
    print("\n")
'''

#打印九九乘法表
i=1
while i<=9:
    j=1
    while j<=i:
        print("{0}*{1}={2}".format(j,i,i*j),end=" ")
        j+=1
    i+=1
    print("\n")
