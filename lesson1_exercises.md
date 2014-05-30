1. What is the value of a after the below code is executed?

a = 1
b = a
b = 3

answer: a is 1

2. What's the difference between an Array and a Hash?

answer: An array is an ordered list of elements. A hash is made of key/value pairs that do not need to be in a particular order

3. Every Ruby expression returns a value. Say what value is returned in the below expressions:

arr = [1, 2, 3, 3]
[1, 2, 3, 3].uniq
[1, 2, 3, 3].uniq!

answer: the first one returns [1,2,3,3], the second annd third return [1,2,3,3]

4. What's the difference between the map and select methods for the Array class? Give an example of when you'd use one versus the other.

answer: map itterates each value in an array and and performs some action on each value

select select itterates over an array and returns a new array from the items that meet a certain condition

map example: ["Doug","Dave","Kevin"].map { |name| "Hi" + name}
			=> ["Hi Doug", "Hi Dave", "Hi Kevin"]

select example: [1,2,3,4,5,6].select { |num| num > 4 }
				=> [5,6]


5. Say you wanted to create a Hash. How would you do so if you wanted the hash keys to be String objects instead of symbols?

answer h = {"name"=>"Doug", "hair"=>"brown", "eyes"=>"blue"}

6. What is returned?

x = 1
x.odd? ? "no way!" : "yes, sir!"

answer: no way!

7. What is X?

x = 1

  3.times do
    x += 1
  end

puts x

answer: x is 4

8. What is X?

3.times do
  x += 1
end

puts x

answer: error, beacause x has not been declared as a local variable
