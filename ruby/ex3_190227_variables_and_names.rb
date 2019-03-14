# variables and names
# 设置变量名和值
car_type="dazhong"
car_number=50
space_of_car=4.0
drivers=30
passengers=90
cars_not_driven=car_number-drivers
cars_driven=drivers
carpool_capacity=cars_driven*space_of_car
average_passengers_per_car=passengers/cars_driven
# 使用变量
puts "there are #{car_number} #{car_type} cars availble"
puts "there are only #{drivers} drivers availble"
puts "there will have #{cars_not_driven} cars empty today"
puts "we can transport #{carpool_capacity} passengers today"
puts "we have #{passengers} people to carpool today"
puts "we need to arrange #{average_passengers_per_car} people in each car"
