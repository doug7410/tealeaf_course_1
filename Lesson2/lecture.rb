# OOP in Ruby
# 1. classes and objects
# 2 . classes contain behaviors
# 3. instance variables contain states
# 4. objects are insteantiated from calases and contain states and behaviors
# 5. class variables and methods
# 6. compare with procedural


class Dog
	attr_accessor :name, :height, :weight

	@@count = 0

	def self.total_dogs
		"total nimber of dogs #{@@count}"
	end

	def initialize(n, h, w)
		@name = n
		@height = h
		@weight = w
		@@count += 1
	end

	def speak
		@name +' barks!'
	end

	#def name
	#	@name
	#end
	#
	#def name=(new_name)
	#	@name = new_name
	#end

	def info
		"#{@name} is #{@height} tall and weighs #{@weight}"
	end
end

tedy = Dog.new('teddy', 3, 95)
fido = Dog.new('fido', 1, 35)
tedy.name = "rosavelt"

tedy.speak
fido.speak
puts tedy.name
puts tedy.height
puts tedy.weight
puts fido.name

puts tedy.info
puts fido.info

puts Dog.total_dogs