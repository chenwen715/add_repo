# 通常情况下，使用 #{variable_name} 来将参数值放入字符串，
# 但参数较多时可使用 %{variable_name}（不确定具体使用场景）
formatter="%{first} %{second} %{third} %{fourth}"
puts formatter % {first:1,second:2,third:3,fourth:4}
puts formatter % {first:"one",second:"two",third:"three",fourth:"four"}
puts formatter % {first:true,second:false,third:true,fourth:false}
puts formatter % {first:formatter,second:formatter,third:formatter,fourth:formatter}

puts formatter % {
  first:"i had this thing.",
  second:"that you could type up right.",
  third:"but it didn't sing.",
  fourth:"so i said goodnight."
}

#打印转行的写法，以下三种均可，前两种使用较多
puts "hello\nworld"

puts %q{hello
world}

puts "hello
world"
