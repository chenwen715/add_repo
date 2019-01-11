#name=input("please input your name:\n")
import sys
import json
from math import floor
import fractions
import math
#print("your name is:",name)
#print("1024*768=",1024*768)
#for i in sys.path:
#	print(i)
#print(int(2.6))
#print(int(-2.6))
#print(floor(2.6))
#print(floor(-2.6))
#print(11//4)
#print(11//-4)
#print(2**4)
#print(12.3%2)
#print(fractions.Fraction(1,3))
#print(math.tan(math.pi/4))
#print(math.sin(math.pi/2))
#s="hello"
#s1=[]
#for i in range(len(s)):
#	a=s[len(s)-i-1]
#	s1.append(a)
#s2="".join(s1)
#print(s2)
l=[1]
l=l+["2"]
print(l)
set={1,2,3}
set.update(["a","c",True],[4,3],{5,"a",False},(8,9))
print(set)#True=1,故不出现True
dict={"a":1,"b":2,1:[3,"bbb"]}
print(dict)
print(dict[1])
print(dict.pop("a"))
print(dict)
#dict.clear()
del dict[1]
print(dict)
del dict
print(dict)