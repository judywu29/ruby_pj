

a = [1,2,3]
b = ["a", "b", "c"]
p a.zip(b).map { |x,y| "#{x}#{y}" }.join(",") #"1a,2b,3c"
p Hash[a.zip(b)] #{1=>"a", 2=>"b", 3=>"c"}


require 'benchmark'

p Array.new(3){Array.new(3,"")}

  a = [1,2,3]
  b = ["a", "b", "c"]
 
  Benchmark.bm do |x|
  x.report("to_h "){a.zip(b).to_h}
  x.report("Hash"){Hash[a.zip(b)]}
end
=begin
        user     system      total        real
to_h   0.000000   0.000000   0.000000 (  0.000010)
Hash  0.000000   0.000000   0.000000 (  0.000009) 
=end

p Math.sqrt(64)

include Math
p sqrt(64)

a = [1, 2, 3, 4] 
# p a.select!{|x| x > 2}
# p a
# p a.keep_if{|x| x > 2}
# p a

p a.cycle(4) ##<Enumerator: [1, 2, 3, 4]:cycle(4)>

a = [1, 2, 3, 4]
p a.fetch(1, 5) #2
p a.pop #4
p a.shift #1
p a.unshift("nice") #["nice", 2, 3]
p a.drop(1) #[2, 3] #drop: don't change a, return an new array without the first element which has been dropped = a[1..-1]
p a.shift(2) #["nice", 2]， 
p a#[3]

obj = Proc.new{|x| x*2}
p obj.call(3)

obj2 = Proc.new{|x, y| x*y }
p obj2.call(2,3)

# def display_block
#  yield
# end
# 
# display_block{puts "Hello"}

# def breakout(session_name)
#   Proc.new { |presenter| puts "#{session_name} #{presenter}" }
# end
# 
# breakout("Programming").call("Powers")

p "Bob".center(40, "*") #"******************Bob*******************"
p "Bob".rjust(40, "*") #"*************************************Bob"

p (1..20).group_by{|x| x.even?} #{false=>[1, 3, 5, 7, 9, 11, 13, 15, 17, 19], true=>[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]}
p (1..20).partition{|x| x.even?} #[[2, 4, 6, 8, 10, 12, 14, 16, 18, 20], [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]]

#Define a method that prints self. Then use this method as a proc to print the numbers 1 to 100.
# def Fixnum
  # def echo
    # puts self
  # end
# end
# (0..100).each(&:echo)

a = [1, 2, 3, 4, 5, 6, 7]
p a.map{|x| x*3 if x.even?}.compact #[6, 12, 18]

a = [1, 2, 3, 4] 
p a.map(&:even?) #[false, true, false, true]

p Array.new(5){rand(1..10)} #from 1 to 10
p Array.new(5){rand(10)}
p Array.new(5){rand} #[0.11575766807999965, 0.6893520822289556, 0.7095611576622672, 0.9631867643855743, 0.5886484085462043]
p Array.new(5){Array.new(10){rand > 0.5 ?  "D" : "A"}}
p Array.new(3){Array.new(3, nil)} #[[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
=begin
 [["D", "D", "D", "A", "A", "A", "A", "A", "D", "A"], 
 ["D", "A", "A", "A", "A", "A", "D", "A", "D", "A"], 
 ["A", "D", "A", "D", "D", "A", "A", "D", "D", "A"], 
 ["A", "A", "A", "A", "A", "D", "D", "A", "A", "A"], 
 ["D", "A", "D", "D", "A", "D", "D", "A", "D", "A"]] 
=end

#Return nil if the variable x is not defined. If x is defined, return the type of variable x.
p defined?(x) #can be used to check if the getter is defined: defined?(@#{name})?

def linear_search arr, value
  n = 0
  while n<arr.length
    return n if arr[n] == value
    n += 1
  end
  "Value not found"
end

#search in a sorted array
def binary_search arr, num, start_index = 0, end_index = (arr.length-1)
  while start_index <= end_index
    middle_index = (start_index + end_index)/2
    return middle_index if arr[middle_index] == num
    arr[middle_index] < num ? binary_search(arr, num, start_index, middle_index-1) : binary_search(arr, num, start_index+1, end_index)
  end
  "Value not found"
end

#Define a method that takes a block with your name as an argument and prints your name n times (where n is specified as an argument).
def print_name(n, &block)
  n.times{yield if block_given?}
end

p print_name(5){puts "power"}



a = "123.12.1234"
Regx = /(\d{3}).(\d{2}).(\d{4})/
matching_part = a.match(Regx).to_s
p matching_part #"123.12.1234"
p matching_part.sub(Regx, '\1-\2-xxxx') #"123-12-xxxx" #replace dot with -

p a.sub(/(\d{3}).(\d{2}).(\d{4})/, '\1-\2-xxxx') #"123-12-xxxx"

require 'pry'
def add num1, num2
  num3 = num1 + num2
  binding.pry
end

File.exist?('employees.csv')

#Calculate the factorial of 10 with a symbol to proc. 阶乘
p (1..10).inject(:*) #3628800

arr = %w{what is the longest word in this arrrrrray}
p arr.max{|x| x.length}


#Find the first number between 1 and 100 that is divisible by 10 and 7.
p (1..100).detect{|x| x if x % 10 == 0 && x % 7 == 0 } #the first element use detect #70

a = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
# [[0, 3, 6], [1, 4, 7], [2, 5, 8]] 
p (0..2).map{|col| a.map{|row| row[col] } }
p a.transpose #[[0, 3, 6], [1, 4, 7], [2, 5, 8]]

a = [[1, 2], [3, 4]] 
b = [[5,6]]
p a | b # a + b [[1, 2], [3, 4], [5, 6]]

a = ["snake", "rat", "cat"]
b = [1, 2, "bat"]

p b & a #[]

a = ["mat", "fat", "bat"] 
p a.all?{|x| x.length == 3} #true

# x, y = gets.chomp.split.map(&:to_i)

# def add
  # num 1 = ARGV[0]
  # num 2 = ARGV[1]
  # eval(num1) + eval(num2)
# end
# p add

a = %w{apple Bear matt Aardvark phat}
p a.sort_by(&:downcase) #["Aardvark", "apple", "Bear", "matt", "phat"]

hash = {bill: 65, bob:42, frank: 89, john: 5}
p hash.sort_by{|_, v| v} #[[:john, 5], [:bob, 42], [:bill, 65], [:frank, 89]]

puts "%10s %30s %10s" %["read".ljust(10), "my".center(30, "*"), "blog".rjust(10)]
#read       **************my**************       blog

letters = ("a".."z").to_a #["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
vowels = %w{a e i o u}
p letters.delete_if{|x| vowels.include?(x)} 

paragraph = "My name is Matt. What is your name? Are you excited to solve Ruby challenges? I am!"
p paragraph.scan(/[.?!]/).length #4


a = "This is a test"
p a.scan (/[aeiou]/) #["i", "i", "a", "e"]

p a.scan(/[a-m]/) #["h", "i", "i", "a", "e"]

p "This is a test".sub(/^../, "hello") #"hellois is a test" if it's /^./: "hellohis is a test"

# fib = [0, 1]
# result = fib
# 8.times do |i|
#   result<< result[-2] + result[-1]
# end
# p result

def fibnacci(n)
  init = [0, 1]
  result = init
  n.times do |i|
    result << result[-1] + result[-2]
  end
  result
end

puts fibnacci(12).inspect

nums = [1, 2, 3]
letters = ['a', 'b', 'c']
result = []

nums.cycle(1) do |x|
    letters.each { |l| result << [x, l] }
end
p result
#[[1, "a"], [1, "b"], [1, "c"], [2, "a"], [2, "b"], [2, "c"], [3, "a"], [3, "b"], [3, "c"]]

result = [1]
6.times { |x| result << result[-1]*10 } #[1, 10, 100, 1000, 10000, 100000, 1000000]
p result


class Array
  def all_start_with_a?
    self.all? {|x| x.start_with? 'a' }
  end
end
p ["all", "in", "the", "family"].all_start_with_a?
p ["aardvark", "anteater"].all_start_with_a?


manly = ['batman', 'manbot', 'mace', 'tulip', 'nah man, nah']
p manly.grep /man/ #["batman", "manbot", "nah man, nah"]









