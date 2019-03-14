# 使用=begin和=end实现多行注释
=begin
print "what's your age?\t"
age=gets.chomp
print "how tall are you?\t"
height=gets.chomp
print "how much do you weight?\t"

# gets获取用户输入，chomp去掉输入内容后面的\n，to_i将输入内容由字符串转为整数
weight=gets.chomp.to_i
puts "your age is #{age},\nyour height is #{height} cm,\nyour weight is #{weight+10} kg"
=end

print "what's the price of the bag?\t"
# to_f将输入内容由字符串转为浮点型数
price=gets.chomp.to_f
puts "10% of the price is #{price*0.1}"
