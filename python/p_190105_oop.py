# -*- coding:utf-8 -*-
a=1
print(id(a))
class Car:
    def __init__(self,color,wheeln):
        self.color=color
        self.wheeln=wheeln

    def __str__(self):
        return "这是一个车类"

class BWN(Car):
    def __init__(self,color,wheeln):
        #调用父类__init__方法1
        #super().__init__(color,wheeln)
        #调用父类__init__方法2
        Car.__init__(self,color,wheeln)
        self.type="bwn"

    def __str__(self):
        return "这是bwn类"
class Patato:
    '''这是烤地瓜类'''
    def __init__(self):
        '''初始化数据'''
        self.cookedLevel=0
        self.cookedString="生的"
        self.condiments=[]
        
class Animal(object):
    def __init__(self, name='动物', color='⽩⾊'):
        self.__name = name
        self.color = color
    def __test(self):
        print(self.__name)
        print(self.color)
    def test(self):
        print(self.__name)
        print(self.color)
        
class Dog(Animal):
    def dogTest1(self):
        #print(self.__name) #不能访问到⽗类的私有属性
        print(self.color)
    def dogTest2(self):
        #self.__test() #不能访问⽗类中的私有⽅法
        self.test()

class base(object):
    def test(self):
        print('----base test----')
class A(base):
    def test(self):
        print('----A test----')
class B(base):
    def test(self):
        print('----B test----')
# 定义⼀个⼦类，继承⾃A、B
class C(A,B):
    pass

    
if __name__=="__main__":
    car1=Car("white",4)
    print(car1.color)
    print(car1)
    bwn1=BWN("blue",2)
    print(bwn1.color)
    print(bwn1)
    '''
    A = Animal()
    #print(A.__name) #程序出现异常，不能访问私有属性
    print(A.color)
    #A.__test() #程序出现异常，不能访问私有⽅法
    A.test()
    print("------分割线-----")
    D = Dog(name = "⼩花狗", color = "⻩⾊")
    D.dogTest1()
    D.dogTest2()
    
    obj_C = C()
    obj_C.test()
    print(C.__mro__) #可以查看C类的对象搜索⽅法时的先后顺序
    '''

