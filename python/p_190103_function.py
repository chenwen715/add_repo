# -*- coding:utf-8 -*-
class InputError(TypeError):pass

def sortby(l,k):
    '''实现按指定key排序（倒序）'''
    l.sort(key=lambda x:x[k],reverse=True)
    print(stus)

def multi():
    '''实现9*9乘法表'''
    n=1
    while n<=9:
        m=1
        while m<=n:
            print("{0}*{1}={2}".format(n,m,n*m),end=" ")
            m+=1
        n+=1
        print("\n")

def getprime(n,m):
    '''求n-m之间的素数'''    
    result=[]
    for i in list(range(n,m)):        
        if i==2:
            result.append(i)
        else:
            j=1
            while j<i-1:
                j+=1
                if i%j==0:
                    break
                if j==i-1:
                    result.append(i)
    return result
                
def isRunNian(year):
    '''判断某一年是否为闰年'''
    if year%400==0 or (year%100!=0 and year%4==0):
        #print("{0}年是闰年".format(year))
        return True
    else:
        #print("{0}年不是闰年".format(year))
        return False

def whichDay(ymd):
    '''判断某天为当年的第几天'''
    if not isinstance(ymd,int):
        raise TypeError("输入不为数字，请输入YYYYMMDD格式的数字")
    elif len(str(ymd))!=8:
        raise InputError("请输入8位数字，且第一位不为0")
    else:
        result=0
        input_str=str(ymd)
        year=input_str[:4]
        mm=input_str[4:6]
        if int(mm)<1 or int(mm)>12:
            raise InputError("输入的月份为{0}，不在1-12之间".format(int(mm)))
        dd=input_str[6:]
        febd=lambda x:29 if isRunNian(x)  else 28
        li=[{"01":31},{"02":febd(int(year))},{"03":31},{"04":30},{"05":31},{"06":30},{"07":31} \
            ,{"08":31},{"09":30},{"10":31},{"11":30},{"12":31}]
        days=[a.get(mm) for a in li if mm in a][0]
        if int(dd)>days:
            raise InputError("输入的天为{0}，超过范围，{1}月只有{2}天".format(int(dd),int(mm),days))
        for i in li:
            if li.index(i)<int(mm)-1:
                for value in i.values():
                    result+=value
        result+=int(dd)
        return result
    
if __name__=="__main__":
    stus =[{"name":"zhangsan", "age":18}, \
       {"name":"lisi", "age":19}, \
       {"name":"wangwu", "age":17}]
    #sortby(stus,"name")
    #sortby(stus,"age")    

    #multi()

    #print(getprime(1,201))

    #isRunNian(1996)
    #print(whichDay(19940104))
