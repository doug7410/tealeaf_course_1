module Speak
	def speak(sound)
		puts "#{sound}"
	end
end

class GoodDog
	include Speak
end

class HumanBeing
	include Speak
end


sparky = GoodDog.new
sparky.speak("Arf!")
bob = HumanBeing.new 
bob.speak("Hello!")


puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

# The object model Exercise 1 and 2

module PlayChord
	def play_chord(chord)
		puts "#{chord}"
	end
end

class Guitar
	include PlayChord
end

les_paul = Guitar.new

puts "A module is a collection of behaviors than can be used in classes via mixins\n"
puts "It is mixed in to a class withy the 'include' keyword"

les_paul.play_chord("C minor")

