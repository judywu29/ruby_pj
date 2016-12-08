

=begin
 reverse_each 
=end

array = ['a', 'b', 'c']
# array.collect!{|x| x.upcase}
# puts array
# 
# array.map!{|x| x.downcase}
# puts array

puts "use block"
p array.collect(&:upcase)
p array.map(&:downcase)
puts "end use blcok"

array = ['junk', 'junk', 'val1', 'val2']
1.upto(array.length-1){|i| puts "#{array[i]}"} #junk, val1, val2
array.each{|x| puts x}

array = ['1', 'a', '2', 'b', '3', 'c']
(0..array.length-1).step(2) do |i|
  puts "#{array[i+1]}" #a b c
end

class Array
  def each_from_both_sides
    front_index = 0
    back_index = self.length-1
    while front_index <= back_index
      yield self[front_index]
      front_index += 1
      if front_index <= back_index
        yield self[back_index]
        back_index -= 1
      end
        
      end
    end
    
   def collect_from_both_sides
     new_array = []
     each_from_both_sides{|x| new_array<<yield(x)}
     return new_array
   end
  end

new_array = []
[1,2,3,4,5].each_from_both_sides{|x|new_array<<x}
puts new_array #1,5,2,4,3

puts ["ham", "eggs", "and"].collect_from_both_sides{|x|x.capitalize} #Ham, And, Eggs

a,b,*c =[12, 14, 178, 89, 90]
puts a, b, c #[178, 89, 90]

#swap
a, b, c= :red, :green, :blue
c, a, b = a, b, c
puts a, b, c # green, blue, red

=begin
 remove the duplicate elements: uniq, uniq!, to_set 
=end

a = [1,2,7,1,2]
puts a.uniq #[1,2,7]

c = [1,2,3]
puts c.reverse #[3,2,1], reverse!

require 'set'
b = a.to_set
puts b.inspect ##<Set: {1, 2, 7}>

games = [["alice", "bob"], ["carol", "ted"], ["alice", "mallory"], ["ted", "bob"]]
players = games.inject(Set.new){|set, game| game.each{|g| set << g}; set} ##<Set: {"alice", "bob", "carol", "ted", "mallory"}>
p players

players << "ted"
p players

# make the set order:
class OrderedSet < Set
  def initialize
    @hash ||= OrderedHash.new
  end
end

#remove nil
a = [1,2,nil, 3, nil]
puts a.compact #[1,2,3]

#remove a particular value
a.delete 3
puts a #[1,2, nil,nil]

=begin
 sort, sort! sort_by 
=end

sort_array = ["ashley", "genny", "bob"]
# sort_array.sort!
# puts sort_array
# 

sort_array.sort_by!(&:length)
p sort_array #["bob", "genny", "ashley"]

# puts sort_array.inspect #bob genny ashley
# 
a = [1,100, 42, 23, 26, 10000]
a.sort!{|x,y| x == 42 ? 1 : x<=>y}
p a #[1, 23, 26, 100, 10000, 42]
# a.sort! do |x, y|
  # x == 42?1:x<=>y # x<=>y: 0: equal, -1: less, 1: greater, so 42 is at the end 
# end
# puts a.inspect #[1, 23, 26, 100, 10000, 42]
# 
list = ["Albania", "anteater", "zorilla", "Zaire"]

list.sort_by!(&:downcase)

p list
# puts list.inspect #["Albania", "anteater", "Zaire", "zorilla"] #use hash is faster than array
=begin
 sort_by: the sort key can be an array, compare two arrays by comparing their corresopnding elements one at a time
 sort an array so that its least-frequently-appearing items come first 
=end



module Enumerable
  def sort_by_frequency
    histogram = inject(Hash.new(0)){|hash, x|hash[x]+=1;hash}
    
    #[3, 8, 9, 16, 2, 2, 4, 4, 4, 1, 1, 1, 1]
    sort_by{|x|[histogram[x], x]} #the same frequency showing up in an unsorted order, the same order as their original order
    # sort_by{|x|histogram[x]} #[16, 8, 3, 9, 2, 2, 4, 4, 4, 1, 1, 1, 1]
    # sort_by{|x|[histogram[x]*-1, x]}#reverse [1, 1, 1, 1, 4, 4, 4, 2, 2, 3, 8, 9, 16]
  end
end
a = [1,2,3,4,1,2,4,8,1,1,4,9,16]
p a.sort_by_frequency.uniq #use uniq: [3, 8, 9, 16, 2, 4, 1]

=begin
 
comparing the first element as frequency
[1,2]<=>[0,2] =>1  
[1,2]<=>[1,3] =>-1 
=end


=begin
 shuffle 
=end

p [1,2,3].sort_by{rand} #[2, 3, 1]

p [1,2,3].shuffle!

class Array
  def shuffle!
    each_index do |i|
      j = rand(length-i)+i
      puts j
      self[j], self[i] = self[i], self[j]
    end
  end
end
puts [1,2,3].shuffle!.inspect

=begin
 min, max 
=end
list1 = [11,5,3,16, 2, 1]
puts list1.min
puts list1.max
list2=["three", "five", "eleven", "sixteen"]
#根据大小来得到最小的
p list2.min{|x, y| x.size<=>y.size} #five

puts list2.max{|x, y| x.size<=>y.size} #sixteen

#get a number of smallest elements:
sorted = list1.sort
puts sorted[0..4].inspect #[1, 2, 3, 5, 11]
puts sorted[-5...sorted.size].inspect #[2, 3, 5, 11, 16]

=begin
 change the array to hash 
=end
#from array->hash
collection = [[1,"one"], [2,"two"], [3, "three"], [4, "four"]]
my_hash = Hash[collection]
p my_hash
 #{1=>"one", 2=>"two", 3=>"three", 4=>"four"}
#from hash->array: to_a
{:key1=>"value1", :key2 => "value2"}.to_a #[[:key1, "value1"], [:key2, "value2"]]
=begin
 2.2.1 :003 > [1,2,3].join
 => "123" 
2.2.1 :004 > [1,2,3].to_s
 => "[1, 2, 3]" #整个变成string
=end

require 'yaml'
puts "ToYaml".to_yaml
=begin
  --- ToYaml
...
=end
array = []
p "123".each_byte{|x| array<<x.chr} #no each, can use scan, split, "123"

p "123".split("") #["1", "2", "3"]
#or

p "123".scan /\d/  #["1", "2", "3"]
# bb =  "123".scan /\d/  
# puts bb.to_s # or inspect ["1", "2", "3"]

=begin
2.2.1 :004 > "abc".scan /./
 => ["a", "b", "c"]
 2.2.1 :008 > "124".scan /\d/
 => ["1", "2", "4"]  
=end
arr = ["a", 1, "b", 2] #has to be pairs
p Hash[*arr] #{"a"=>1, "b"=>2}
















