
module OffRoad
	def four_wheel_drive
		"Tunrn on 4X4!"
	end
end

class Vehicle
	attr_accessor :color
	attr_reader :year, :model
	@@number_of_vehicles = 0


	def self.calculate_mpg(miles, fuel)
		mpg = miles / fuel
		puts "You are gettin #{mpg} miles per gallon"
	end

	def self.show_num_vehicles
		puts @@number_of_vehicles
	end

	def speed_up(number)
		@current_speed += number
		puts "You push the gas and accelerate to #{number} mph."
	end

	def brake(number)
		@current_speed -= number
		puts "You push the brake and decelerate #{number} mph."
	end

	def current_speed
		puts "You are new going #{@current_speed} mph."
	end

	def shut_down
		@current_speed = 0
		puts "Lets park this pile of junk!"
	end

	def spray_paint(color)
		self.color = color
		puts "Your color is now #{self.color}!"
	end

	def initialize(y,c,model)	
		@@number_of_vehicles += 1
		@year = y
		@color = c
		@model = model
		@current_speed = 0
	end

	def age
		"this #{self.model} is #{calc_age} years old"
	end


	private

	def calc_age
		Time.now.year - self.year
	end

end


class MyCar < Vehicle

	VEHICLE_TYPE = "car"


	def to_s
		"this car is a #{self.year} #{@model} and it's #{self.color}"
	end
end

class MyTruck < Vehicle
	VEHICLE_TYPE = "truck"

	include OffRoad

	def to_s
		"this truck is a #{self.year} #{@model} and it's #{self.color}"
	end
end


class Student

	attr_accessor :name	

	def initialize(n,g)
		@name = n
		@grade = g
	end

	def better_grade_than?(other_student)
		return true if "ABCDF".index(grade) <  "ABCDF".index(other_student.grade)
	end

	#private 

	attr_accessor :grade
end

joe = Student.new("Joe","F")
steve = Student.new("Steve","B")

puts joe.name
puts steve.name
if joe.better_grade_than?(steve)
	puts "Well done!"
else
	puts "Try harder"
end


#sprint = MyCar.new(1992, "red", "Chevy Sprint")
#f150 = MyTruck.new(2200, "glowing blue", "Ford F150")
#sprint.speed_up(5)
#sprint.current_speed
#sprint.speed_up(2)
#sprint.current_speed
#sprint.brake(5)
#sprint.current_speed
#sprint.brake(2)
#sprint.current_speed
#sprint.shut_down
#sprint.current_speed
#puts sprint.color
#puts sprint.year
#
#puts f150.four_wheel_drive
#
#MyCar.calculate_mpg(200,10)
#
#Vehicle.show_num_vehicles
#
#puts sprint.spray_paint("green")
#
#puts "---Vehicle methods---"
#puts Vehicle.ancestors
#puts ''
#puts "---MyCar methods---"
#puts MyCar.ancestors
#puts ''
#puts "---MyTruck methods---"
#puts MyTruck.ancestors
#puts ''
#
#puts f150
#puts sprint
#
#puts '------'
#puts sprint.age
#puts f150.age#