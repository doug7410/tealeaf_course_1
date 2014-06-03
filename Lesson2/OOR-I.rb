class GoodDog
	
	attr_accessor :name, :height, :weight

	def initialize(n,h,w)
		@name = n
		@height = h
		@weight = w
	end

	def speak
		"#{name} says arf!"
	end

	def change_info(n,h,w)
		self.name = n
		self.height = h
		self.weight = w
	end

	def info
		"#{self.name} weighs #{self.weight} and is #{self.height} tall"
	end

	def some_method
    self.info
	end

end
#
#sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
#puts sparky.info
#
#sparky.change_info('Sparticus', '24 inches', '45 lbs')
#puts sparky.some_method

#fido = GoodDog.new("Fido")
#
#puts fido.speak
#
#puts sparky.name
#
#sparky.name = "Sparticus"
#
#puts sparky.name

class MyCar

	attr_accessor :color

	attr_reader :year

	def initialize(y,c,model)	
		@year = y
		@color = c
		@model = model
		@current_speed = 0
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

	def spray_paint
		puts "The car is #{self.color} right now.\n\n "
		puts "What color would you like to paint it?\n\n"
		new_color = gets.chomp 
		self.color = new_color
		puts "The car is now #{self.color}!"
	end

	def self.calculate_mpg(miles, fuel)
		mpg = miles / fuel
		puts "You are gettin #{mpg} miles per gallon"
	end

	def to_s
		"this car is a #{self.year} #{@model} and it's #{self.color}"
	end
end



sprint = MyCar.new(1992, "red", "Chevy Sprint")
sprint.speed_up(5)
sprint.current_speed
sprint.speed_up(2)
sprint.current_speed
sprint.brake(5)
sprint.current_speed
sprint.brake(2)
sprint.current_speed
sprint.shut_down
sprint.current_speed
puts sprint.color
puts sprint.year

#sprint.spray_paint

MyCar.calculate_mpg(200,10)

puts sprint

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Doug"

puts bob.name