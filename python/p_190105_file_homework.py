# -*- coding:utf-8 -*-
'''
1. 读取⼀个⽂件，显示除了以井号(#)开头的⾏以外的
所有⾏
2. 制作⼀个"密码薄",其可以存储⼀个⽹址（例如
www.itcast.cn），和⼀个密码(例如 123456)，请编
写程序完成这个“密码薄”的增删改查功能，并且实现
⽂件存储功能
'''
def readFileWithoutSharp(file):
    try:
        with open(file,mode="r",encoding="utf-8") as f:
            for line in f:
                if not line.startswith("#"):
                    print(line)        
    except (FileNotFoundError,NameError) as errormsg:
        print(errormsg)
    else:
        print("无异常")
    finally:
        print("结束")

if __name__=="__main__":
    readFileWithoutSharp("p_181230_condition.py")
