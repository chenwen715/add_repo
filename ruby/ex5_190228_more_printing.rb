# #{}里面有单引号，则视为字符串，#{}里面只有变量名，则使用变量的值
weather="sun"
puts "today's weather :#{weather}"
puts "today's weather :#{'weather'}"

# 打印10个*
puts "*"*10


x1="h"
x2="e"
x3="l"
x4="l"
x5="o"
# print打印字符串后不换行，puts打印字符串后自动换行
print x1+x2
puts x3+x4
puts x5
