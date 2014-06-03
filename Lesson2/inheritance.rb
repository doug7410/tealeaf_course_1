#class GoodDog < Animal
#	attr_accessor :name
#
#	def initialize(n)
#		self.name = n
#	end
#
#	def speak
#		"#{self.name} says arf!"
#	end
#end
#
##sparky = GoodDog.new("Sparky")
#paws = Cat.new
#
#puts sparky.speak
#puts paws.speak

module Walkable
	def walk
		"I'm walking"
	end
end

module Swimmable
	def swim
		"I am swimming"
	end
end

module Climbable
	def climb
		"I'm climbing"
	end
end

class Animal
	include Walkable

	def speak
		"I'm an animal and I speak!"
	end

	def a_public_method
		"Will this work " + self.a_protected_method
	end

	protected

	def a_protected_method
		"Yes, I'm protected!"
	end

end

class Fish < Animal
	include Swimmable
end

class Mammal < Animal
end



class Cat < Mammal
end

class Dog < Mammal
	include Swimmable
end

class GoodDog < Animal
	include Swimmable
	include Climbable

	DOG_YEARS = 7

	attr_accessor :name, :age

	def initialize(n, a)
		self.name = n
		self.age = a * DOG_YEARS
	end

	def public_disclosure
		"#{self.name} in human years is #{human_years}"
	end

	private

	def human_years
		self.age / DOG_YEARS
	end

end


sparky = GoodDog.new("Sparky", 4)
puts sparky.public_disclosure
neemo = Fish.new
paws = Cat.new

fido = Animal.new
puts fido.a_public_method
puts fido.a_protected_method

puts fido.speak
puts fido.walk



