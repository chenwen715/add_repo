# 命令行中输入 ruby ex9_190305_param.rb param1 param2 param3 运行脚本
# 少参数则为空，多参数则舍弃
# 程序获得的参数均为字符串格式
first,second,third=ARGV
puts "your first variable is #{first}"
puts "your second variable is #{second}"
puts "your third variable is #{third}"

# 使用了ARGV后再想从键盘获取输入信息时，需使用$stdin.gets.chomp
# 若还是使用gets.chomp报错
puts "please input something: "
fourth=$stdin.gets.chomp
puts fourth
