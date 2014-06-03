#class GoodDog
#  @@number_of_dogs = 0
#
#  def initialize
#    @@number_of_dogs += 1
#  end
#
#  def self.total_number_of_dogs
#    @@number_of_dogs
#  end
#end
#
#puts GoodDog.total_number_of_dogs   # => 0
#
#dog1 = GoodDog.new
#dog2 = GoodDog.new
#
#puts GoodDog.total_number_of_dogs   # => 2

#class GoodDog
#	DOG_YEARS = 7
#	attr_accessor :name, :age
#	def initialize(n,a)
#		self.name = n
#		self.age = a * DOG_YEARS
#	end
#	def to_s
#		"This dog's name is #{name} and it's age is #{age} in dog years."
#		end
#	end
#	

class GoodDog
	attr_accessor :name, :height, :weight

	def initialize(n, h, w)
		self.name = n
		self.height = h
		self.weight = w
	end

	def change_info(n, h, w)
		self.name = n
		self.heigh = h
		self.weight = w 
	end

	def info
		"#{self.name} weighs #{self.weight} and is #{self.height} tall"
	end

	def what_is_self
		self
	end

	puts self
end

sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
p sparky.what_is_self

class MyAwesomeClass
  def self.this_is_a_class_method
  	puts "mwagahahahahah"
  end
end

MyAwesomeClass.this_is_a_class_method