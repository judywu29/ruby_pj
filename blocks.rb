#p: only prints to stdout, printed version contains no newlines, making it difficult to read large hashes,
# puts can be used to print to the file
#use pp


def times_n(n)
  lambda {|x| x*n }
end

times_ten = times_n(5)
p times_ten.call(10) #50

circu = times_n(2*Math::PI)
p [1,2,3].collect(&circu) #[6.283185307179586, 12.566370614359172, 18.84955592153876]

################################Array
#each, collect, select, each_with_index, reverse_each
[1,2,3,4].reverse_each {|x| puts x}
arr = ['a', 'b', 'c']
arr.map!(&:upcase)
p arr


arr = ['junk', 'junk', 'junk', 'val1', 'val2']
3.upto(arr.length-1){|i| puts arr[i]}
(0..arr.length-1).each { |i| puts arr[i]}

#把重复的代码 block起来，在函数里面是使用yield

#inject, uniq
require 'set'
games = [["Alice", "Bob"], ["Carol", "Ted"], ["Alice", "Mallory"], ["Ted", "Bob"]]

players = games.inject(Set.new){|set, game| game.each {|p| set << p}; set}
puts players.inspect ##<Set: {"Alice", "Bob", "Carol", "Ted", "Mallory"}>


#inject used to create a new array, set, hash


##########################sort
#just sort, min, max, similar way {|x, y| x.size<=>y.size}
puts [5.01, -5, 0, 5].sort
#use sort_by
arra = [[1,2,3], [100], [10, 20]]
puts arra.sort_by {|x| x.size}

################make sure an array stays sorted###########
class SortedArray < Array
  def initialize *args, &sort_by
    @sort_by = sort_by || Proc.new {|x, y| x<=>y}
    super *args
    sort! &@sort_by
  end
  
  def insert i, v
    insert_before = index(find{|x| @sort_by.call(x, v) == 1})
    super(insert_before ? insert_before : -1, v)
  end
  
  def <<(v)
    insert(0, v)
  end
  
  alias push <<
  alias unshift <<
end

a = SortedArray.new([3,2,1])
p a #[1, 2, 3]
a<<0
a<<4

p a #[0, 1, 2, 3, 4]

####################sort by frequency
module Enumerable
  def sort_by_frequency
    hist = inject(Hash.new(0)){|hash, x| hash[x] += 1; hash}
    sort_by{|x| [hist[x], x] } #passing array, 可以保持原有的顺序
  end
  
  def min_n n, &block
    blk = block || Proc.new{|x, y| x<=>y}
    stable = SortedArray.new(&blk)
    each do |x|
      stable << x if (stable.size < n) or (blk.call(x, stable[-1]) == -1)
      stable.pop if stable.size > n
    end
    stable
  end
  
  def max_n n, &block
    blk = block || Proc.new{|x, y|x<=>y}
    stable = SortedArray.new(&blk)
    each do |x|
      stable << x if (stable.size < n) or (blk.call(x, stable[0]) == 1) # 因为刚刚插入的总是最大的
      stable.shift if stable.size > n  #delete the last one
    end
    stable
  end
end

a = [1,2,3,4,0,2,4,8,-1,4,9,16]
p a.sort_by_frequency
p a.min_n(3)    #[-1, 0, 1]
p a.max_n(3)  #[8, 9, 16]

a = ("a".."h").to_a
p a[2..5] #["c", "d", "e", "f"]
# p a.slice!(2..3) #["c", "d"]
p a.find_all{|x| x < 'e'} #select
p "again"
p a.reject{|x| x < 'e'}
p a.detect{|x| x > 'e'} #'f'
puts a.grep /[aeiou]/
puts a.grep /^g/ #g

p [3,3] | [3, 3]  #[3]
p [3, 3] & [3,3]  #[3]
p [1,2,3,3]- [1]  #[2, 3, 3]
p [1,2,3,3] - [3]  #[1, 2]
p [1,2,3,3] - [2,2,3]  #[1]

######################hash
h = Hash.new{|hash, key| (key.respond_to? :to_str) ? "nope" : nil}

puts h[1] #nil
puts h['do you have this string'] #nope

h.delete('do you have this string') #key
puts h #{}
h[1] = "hello"
h[2] = "Jane"
p h #{1=>"hello", 2=>"Jane"}
p h.reject{|_, v| v == "hello"} #only on the copy, will not delete on the h: {2=>"Jane"}
p h #{1=>"hello", 2=>"Jane"}
h.delete_if{|k, v| v == "hello"} #{2=>"Jane"}
p h #{}

active_toggles = {:super => true, :meta=>true, :hyper=>true}
active_toggles.each_key{|active| puts active}
active_toggles.each_value{|active| puts active}
active_toggles.has_value? false
# for hash, there's no sort method, only sort_by
extensions = {:Alice => 104, Carol: 210, Bob: 110}
extensions.keys.sort.each do |k|
  puts extensions[k]
end

to_do = {'Clean car'=> 5, 'Take kangaroo to vet'=> 3, 'Realign plasma conduit'=> 3}

to_do.sort_by{|k, v| [v, k]}.each{|k, v| puts k} 
p to_do.sort_by{|_, v| v}
#[["Realign plasma conduit", 3], ["Take kangaroo to vet", 3], ["Clean car", 5]]
=begin
Realign plasma conduit
Take kangaroo to vet
Clean car 
=end

h1 = {}
h1[1] = 1
h1["second"] = 2
h1[:third] = 3

p h1

require 'orderedhash'
h2 = OrderedHash.new
h2[1] = 1
h2["second"] = 2
h2[:third] = 3
puts h2  #[[1, 1], ["second", 2], [:third, 3]]
p h2 #{1=>1, "second"=>2, :third=>3} 

require 'pp'
pp h2 #{1=>1, "second"=>2, :third=>3}

require 'yaml'
puts h2.to_yaml
=begin
 ---
1: 1
second: 2
:third: 3 
=end

#########################一般把循环内的动作当作block外包出去， 用yield代替#########################
class Hash
  # def tie_with(hash)
    # remap do |h, key, value|
      # h[hash[key]] = value
    # end.delete_if{|key, value| key.nil? || value.nil?}
  # end
#   
  # def remap(hash={})
    # each {|k,v| yield hash, k, v}
    # hash
  # end
  def tie_with(hash)
    each do |k, v|
      h = {}
      h[hash[k]] = v
    end.delete_if{|key, value| key.nil? || value.nil? }
  end
end

a = {1=>2, 3=>4}
b={1=>'foo', 3=>'bar'}
p a.tie_with(b) #{"foo"=>2, "bar"=>4}
p b.tie_with(a) #{2=>"foo", 4=>"bar"}

class Hash
  def find_all
    new_hash = Hash.new
    each{|k,v| new_hash[k] = v if yield(k, v) }
    new_hash
  end
end
squares = {0=>0, 1=>1, 2=>4, 3=>9}
p squares.find_all{|key, value| key>1} #{2=>4, 3=>9}

accumulator = []
[1,2,3].reverse_each{|x| accumulator << x+ 1}
p accumulator #[4, 3, 2]

class Tree
  attr_reader :value
  def initialize value
    @value = value
    @children = []
  end
  
  def <<(value)
    subtree = Tree.new(value)
    @children << subtree
    return subtree
  end
  
  def each
    yield value
    @children.each do |child_node|
      child_node.each {|e| yield e}
    end
  end
end

t = Tree.new("Parent")
child1 = t<<"Child 1"
child1 << "Grandchild 1.1"
child1 << "Grandchild 1.2"

child2 = t << "Child 2"
child2 << "Grandchild 2.1"
    
t.each {|x| p x}

=begin
 "Parent"
"Child 1"
"Grandchild 1.1"
"Grandchild 1.2"
"Child 2"
"Grandchild 2.1" 
=end

#detect: the iteration may stop once it finds an element that matches. 
#find_all: goes through all elements, collection the ones that match. 
#collect: collect the values returned by the code block in a new data structure, and return the data structure once 
#the iteration is completed. 

=begin
each——连续访问集合的所有元素  
collect—-从集合中获得各个元素传递给block，block返回的结果生成新的集合。  
map——-同collect。  
inject——遍历集合中的各个元素，将各个元素累积成返回一个值。 
=end
module Enumerable
  def find_no_more_than(limit)
    inject([]) do |a, e|
      a << e if yield e
      return a if a.size >= limit
      a
    end
  end
end
a = [1,2,3,4,5,6,7,8,9]
p a.find_no_more_than(3) {|x| x % 2 == 0} #[2, 4, 6]

#Proc.new 中不能用break
aBlock = Proc.new do |x|
  puts x
  break if x == 3 #no exception
  puts x+2
end
aBlock.call(5)

#use catch/throw to replace break
catch :skip do
  puts 'hello'
  throw :skip # 離開 catch :skip 區塊
  puts 'world' # 不會被執行到
end



      































