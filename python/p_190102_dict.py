# -*- coding:utf-8 -*-
sam={"name":"sam","height":172,"age":20}
print(sam.get("age",4))#有age属性则为age的值，没有则为第二个参数的值
print(sam.get("weight",70))
