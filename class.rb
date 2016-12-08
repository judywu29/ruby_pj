=begin
 check if the object has the method, or the object is a specific type 
=end

def send_as_package(obj)
  if obj.respond_to? :package
    packaged = obj.package
  elsif
    $stderr.puts "Not sure how to package a #{obj.class}"
    package = Package.new obj
  end
  send(package)
end

def multiple_precisely a, b
  if a.is_a? Float or b.is_a? Float
    $stderr.puts 'cannot do precise multipcation'
  end
  a*b
end
puts multiple_precisely 4,5
puts multiple_precisely 4.0, 5   #'cannot do precise..'

def append_to_self x
  unless x.respond_to? :<<
    raise ArgumentError, "This object doesn't support the left-shift operator"
    
  end
  if x.is_a? Numeric
     raise ArgumentError,  "The left-shift operator for this object doesn't do an append"
    
  end
  x<<x
end
puts append_to_self 'abc' #'abcabc'
puts append_to_self [1,2,3] #1 2 3 [...]
# puts append_to_self 5

=begin
 reopen the class or (subclass)write a new class to inherit the class??????? 
=end

=begin
 *arg variable numbers of arguments
=end
class Rectangle
  def initialize(*args)
    case args.size
    when 2
      @top_left, @bottom_right = args

    when 3
      @top_left, length, width = args
      @bottom_right = length + width
    else
      raise ArgumentError, "need 2 or 3 arguments"
   end
   puts @top_left.inspect, @bottom_right.inspect   
  end
end

puts Rectangle.new [10,23],[14,13] #cannot have braces?????
puts Rectangle.new [10,23],4,10

array = [15,14,13]
Rectangle.new *array #use asterisk to pass an array, don't need[] to *xx, or else, it's treated as a single argument
#*args: add [] to the element, if it's array already, add *
# Rectangle.new array #need 2 or 3 arguments

=begin
 setter: name=()
 getter: name 
=end
############################################################################################
=begin
  
下面都是应万变的方法： 

All about proxies:assistant/managers; client/proxy, client/remote proxy/authentication;
def method_missing name, *args, use const_missing when we reference a const
  
The sexy thing about method_missing: only entry about access to the object, we can do anything we want in this method, to call the method, 
  or handle anything small/clear/simple in this method, we don't have to define any method extrally. we can also restrict the access to the
  methods, like forwardable to define the methods we use
  we can use "send": can send to the private instance methods
  
  
shortcoming: 1. when there's a real method, method_missing won't be called, because it searches the method all around, 
usually this happens when the argument(name) is already a name of a method(not our want), so the method will be called. can be fixed by
m is sysmble, has to use to_s to string
instance_methods.each do |m|
  undef_method m unless m.to_s =~ /^(__|method_missing|respond_to?)/
end

__xxx: used internally by Ruby. cannot remove them
or inherit from BasicObject(blank slate)

2. performance, slower: method lookup tends to take a longer route when call a ghost method
there's no method defined, and will traverse all of the classes to find the methods/instance_methods,

3. has to redefine respond_to? method

Dynamic proxy: using method_missing on the wrapper, use delegator, use forwardable module
 delegate wrapping, add more functions/feature
 proxy pattern design: controlling access to an object, providing a location-independent way of getting the object(remote proxies, RPC)
 delay it's creation @subject ||= @creation_block.call @creation_block is assigned when initializing
=end
#method 1:most of the methods in Kernel won't delegate: public_instance_methods: is_a?
require 'delegate'
class OrdinalNumber < DelegateClass Fixnum
  def to_s
    delegate_s = __getobj__.to_s
    check = abs #return absolute value
    if check == 11 or check == 12
      suffix = "th"
    else 
      case check %10
      when 1 
        suffix = "st"
      when 2 
        suffix = "nd"
      else 
        suffix = "th"
      end
    end
    return delegate_s + suffix
  end
end

puts OrdinalNumber.new(4).to_s

#method2: using method_missing: 10% slower 
class VirtualProxy
  def initialize(&block)
    @creation_block = block
  end
  #only when it's the right assignment, it's called and the object is created.
  def subject
    @s ||= @creation_block.call #delay object creation, when initialize the proxy, it doesn't initialize the real object, only when methods call
  end
  
  def to_s
    s = subject
    s.inspect #["hello, VirtualProxy"] or s.to_s
  end
  
  def method_missing name, *args
    s = subject
    s.send name, *args
  end
end

array = VirtualProxy.new{Array.new}
array << "hello, VirtualProxy"
puts array
puts array.to_s ##<VirtualProxy:0x007f89db1eca00> directly use the to_s from Object, because this proxy class inherits from Object
#methods from Object would not be go through the original class(Array)
puts "hello".to_s #hello

#method_missing 也可以算是warpping， 结合send方法
class Computer
  def initialize id
    @id = id
  end
  
  # def resetid new_id
    # @id = new_id
    # puts %{reset id as: #{@id}}
  # end
  
  #usually we don't have to define the method like reset_id, just implement it in method_missing, especially when it's simple to put into one method
  def method_missing name, *args
    # send name, args[0]
    @id = args[0]
    puts %{reset id as: #{@id}} #reset id as: 7
  end
    
end

Computer.new(5).resetid 7 #reset id as: 7

#it approves that it's sexy to just redefine a method_missing when we just need 1 method: 
#people outside don't need define a method, just input the arguments.
class Roulette
  def method_missing name, *args
    person = name.to_s.capitalize
    number = 0
    3.times do
      number = rand(10) + 1
    end
    p %{person:#{person} got a number: #{number}}
  end
end

rlt = Roulette.new
rlt.bob #"person:Bob got a number: 5"
rlt.frank #"person:Frank got a number: 2"

#example:
require 'builder'
xml = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
xml.coder{
  xml.name 'Matsumoto', :nickname=>'Matz'
  xml.language 'Ruby'
}
#xml.name, xml.language are defined in method_missing:
=begin
 <coder>
  <name nickname="Matz">Matsumoto</name>
  <language>Ruby</language>
</coder> 
=end 

#class will not clash with inherited method class(), Builder inherits from a Blank Slate, removes class and other methods from Object
xml.semester{
  xml.class 'Egyptology'
  xml.class 'Ornithology'
}
=begin
 <semester>
  <class>Egyptology</class>
  <class>Ornithology</class>
</semester> 
=end
################################Blank Slate##############################
#classes that inherit directly from BasicObject are automatically Blank Slates!!!!!!!!!!!!!!so convienient. 
class BlankSlate
  def self.hide name
    method_name = name.to_s
    if instance_methods.include? method_name and method_name !~ /^(__|instance_eval)/
      @hidden_methods ||= {}
      @hidden_methods[method_name.to_sym] = instance_method name
      undef method_name
    end
  end
  
end
# instance_methods.each {|m| hide m}
################################Blank Slate##############################


#method3: forwardable:just need part of the methods of some class
require 'forwardable'
class AppendOnlyArray
  extend Forwardable
  def initialize
    @array = []
  end
  def_delegator :@array, :<<
end

a = AppendOnlyArray.new
a<<4
puts a.inspect
# puts a.size #undefined method `size'

class RandomAccessHash
  extend Forwardable
  def initialize
    @delegate_to = {}
  end
  def_delegators :@delegate_to, :[], :[]= #only support random access of Hash
end

balances_by_account_number = RandomAccessHash.new
balances_by_account_number["aa"] = 412.6

puts balances_by_account_number["aa"]

#method4: use alias to wrap old methods
#shortcomings: 1. MonkeyPatch 2. if load an Around Alias twice, the old version becomes new version method
class String
  alias :real_length :length
  
  def length
    real_length > 5 ? 'long':'short' #other places might need original method, break libraries
  end
end

puts "war and peach".length #long
puts "war and peach".real_length #13

#########################################################################################################


 {:key1=>"value1", :key2 => "value2"}.to_a #[[:key1, "value1"], [:key2, "value2"]]
 
 CONSTANT = 10
 ranges = [[1,10], [1,6,true], [25,100, false]]
 new_range = ranges.collect{|x|Range.new(*x)}
 puts new_range.to_s #[1..10, 1...6, 25..100]

=begin
 constant: when points to a mutable object like an array or a string, it can be changed
  
=end
RGB_COLOR = [:red, :green, :blue]
RGB_COLOR<<:purple
p RGB_COLOR #[:red, :green, :blue, :purple]
RGB_COLOR.freeze
# RGB_COLOR<<:black #can't modify frozen Array (RuntimeError)
p RGB_COLOR #[:red, :green, :blue, :purple]

=begin
 singleton:
 1. Class methods: Regexp.compile, Date.parse, Dir.open, Marshal.load
 2. Utility or helper methods associated with a class: Regexp.escape, Dir.entries, File.basename
 3. Accessors: Dir.chdir, GC.disable, GC.enable, all of methods of Process 
=end

class MyClass
  def initialize
    @var1 = 5
  end
  private 
  def set_var
    @var1 = 10
    puts @var1
  end
end

MyClass.new.send :set_var #cannot call it, it's private, but can use send


=begin
 operator overloading
 +: Fixnum#+() 
=end

# class Fixnum
  # alias :old_plus :+ 
#   
  # def + value
    # old_plus(value).old_plus(value)
  # end
# end
# 
# puts 1+1 #3
######################################################################
######################################################################
=begin
 
Flat Scope: they all with block
 block: store the block and execute it later, it will capture the local bindings like x!!!!!!!!!!!AMAIZING AMAZING
 instance_eval: can access to the variables outside the block, capture the local bindings
 define_method
 Class.new do..
 lambda{}, Proc.new{}
 
 not like scope gate like class, module, def
 global variables can be accessed by any scope
 scope: access to the variables
 instance_eval
 lambda, proc 
=end

def a_method
  x = "world"
  return yield if block_given?
end

a_method #run time error if there's no "if block_given?": `a_method': no block given (yield)
x = "hello"
a_method{p "here's a block. and " + "#{x}"} #"here's a block." "here's a block. and hello"

#block can change the local variables
def method_2
  yield 2
end

x = 1
method_2{|y| x = y; puts "#{x}"} #can change the variable x
p "x is: #{x}" #2

######################across scope gates#######################
=begin
 Flat scope
 use Class.new, Module.new, define_method :XXX 
=end
my_var = "Hello, it's me. "
# NewClass = Class.new do
  # puts "enter class" + "#{my_var}"
  # def my_method
    # puts "hello"
    # puts "#{my_var}" #undefined local variable or method `my_var'
  # end
# end


#replace class XXX{}
NewClass = Class.new do
  puts "enter class" + "#{my_var}"
  define_method :my_method do
    puts "hello"
    puts "#{my_var}" #Hello, it's me. has to use block, then can access to the my_var outside the scope of class and def
  end
end

NewClass.new.my_method

##########################################shared scope###################################
def share_method
  shared = 0
  
  #replace def:
  # define_method :method1 do
    # shared += 1
    # puts "XXXX"
    # puts "#{shared}"
  # end
  
  #this way the method2 will be called by send??
  # define_method :method2 do #Kernel.send will 
    # shared += 1
    # puts "#{shared}"
  # end
  # Kernel.send :method2  
  
  Kernel.send :define_method, :method2 do #Kernel.send will not call the method
    shared += 1
    puts "#{shared}"
  end
end

share_method
# method1
# method2


##########################################instance_eval###################################
=begin
 instance_eval: can access to private instance_variable , only used in class scope or XXX.class_eval 
 Be
=end 


##########################################instance_eval###################################
class EvalClass
  attr_accessor :v
  @v = 2
  def initialize
    @x, @y = 2,1
  end
end
EvalClass.class_eval do
  define_method :add_instance_method do #but we can use here, because it's in class scope
     p "add_instance_method is called"
   end
end

# EvalClass.instance_eval do
  # define_method :add_class_method do
    # p "add class method"
  # end
#   
   # define_method :add_class_method do
    # p "add class method"
  # end
# end
EvalClass.new.add_instance_method

obj = EvalClass.new
obj.add_instance_method #"add_instance_method is called"
obj.instance_exec(3){|arg| v = (@x+@y) * arg; p v}#??????????????

obj.instance_eval do
  @v = 3
# define_method: Defines an instance method in the receiver. The method parameter can be a Proc, a Method or an UnboundMethod object. 
# If a block is specified, it is used as the method body. This block is evaluated using instance_eval on Class, not on object
  #but we can use def
  self.class.send :define_method,  :add_method do #Object.private_methods.sort and cannot use explicit receiver
    p "add_method is called"
  end
  #this is singleton method, only on obj
  # def add_method
    # p 'add_method is called'
  # end
end
p obj.v #3
obj.add_method #"add_method is called"
p obj.singleton_methods.sort.inspect #"[:add_method]"

#RSpec?????????????????????????????

def math(a,b)
 yield a,b
end

def teach_math a, b, &block
  p 'lets do math'
  p math a, b, &block
end
teach_math(2,3){|x,y| x*y} #6

require 'highline'
h1 = HighLine.new
# friends = h1.ask("Friends", lambda{|s|s.split(",")})
# p "You're friends with: #{friends.inspect}"  #=> ["Jeff", "Delia", " Diana"] 


#############################################################################
=begin
 difference between proc and lambda
 1.return: lambda return from lambda, proc: return from the scope where proc itself was defined 
 2. proc doesn't have strict arguments check
=end
def double callable_object
  callable_object.call * 2
end

l = lambda { return 10 }
puts double l #20
# l2 = Proc.new {return 10} # it tries to return from this level(where it's defined, but it's called in double, cannot return from double method.)

# puts double l2 #unexpected return 


def another_double
  p = Proc.new{return 10}
  result = p.call
  return result * 2 #unreachable code
end
puts another_double #10

p = Proc.new{|x, y| [x,y]}
p.arity #2
p p.call 1,2,3 #[1, 2]

l = lambda{|x, y| [x,y]}
# p l.call 1,2,3 #wrong number of arguments (3 for 2) 

def triple callable_object
  callable_object.call 5
end
factor = 3
l = lambda{|x| x*factor}
p triple l #15

p = Proc.new{|x| x*factor}
p triple p #15




def my_method
  yield 2
end
x = 1
my_method do |x|
  p x #2
end


class C
  
  def self.class_method
    puts "class_methods is called"
  end
  
  def initialize n
    @x, @y = 1,2
    # class_method
    self.class.send(:define_method, n) {puts "defined some methods"} #define_method is private, class method, have to use send
  end
  
  def anther_method
    # self.class.send :class_method
    self.class.class_method
  end
end

C.new("abc").abc
# C.class_method
p C.new("c").instance_exec(4){|arg| (@x + @y) * arg} #20


=begin
 
keep the same interface: 
 rules:use alias_method_chain, require 'active_support/all'
 2. define 2 methods: xx_without_AAA, xx_with_AAA
 3. use AAA in alias_method_chain, AAA is the feature, xx is the target 
 
alias_method_chain(target, feature) Link
Encapsulates the common pattern of:

alias_method :foo_without_feature, :foo
alias_method :foo, :foo_with_feature
With this, you simply do:

alias_method_chain :foo, :feature
And both aliases are set up for you.

Query and bang methods (foo?, foo!) keep the same punctuation:

alias_method_chain :foo?, :feature
is equivalent to

alias_method :foo_without_feature?, :foo?
alias_method :foo?, :foo_with_feature?
so you can safely chain foo, foo?, foo! and/or foo= with the same feature.

Source: show | on GitHub
=end
#use Active support separately
require 'active_support/all'
class AliasClass
  include ActiveSupport
  
  def write_line(line)
    puts line
  end
  
  def write_line_with_timestamp line
    write_line_without_timestamp("#{Time.now}: #{line}")
  end

  def write_line_with_numbering line
    @number = 1 unless @number
    write_line_without_numbering("#{@number}: #{line}")
  end
  # alias_method_chain :write_line, :timestamp ##2015-08-18 09:19:31 +1000: hello
  alias_method_chain :write_line, :numbering #1: hello
end

AliasClass.new.write_line "hello"  

def map_method(*args)
  args.map(&:reverse)
end

p map_method('abc', 'xyz', '123') #["cba", "zyx", "321"]
#map: *args => array, array=>array+operation

class Foo
  def self.bar
    puts 'bar'
  end
  class<<self
    def baz
      puts 'baz'
    end
  end
end
p Foo.singleton_methods #[:bar, :baz]

#use method_missing to define attr setter and getter: this is where we use method_missing: 
#don't have to define those the methds in advance because we don't know what customer needs
#we can define setter or getter or just use instance_variable_set or _get

#or if we don't define inside the class, we can use class_eval to reopen the class to 
#define setter and getter
class MyOpenStruct
  private
  def method_missing name, *args
    iv = "@#{name.to_s}"
    if name[-1] == "="
      instance_variable_set(iv.chop, args.first)#chop: delete the last character and return the new string
    else instance_variable_get(iv)
    end
  end
end

myopenstruct = MyOpenStruct.new
myopenstruct.bob = "bob"
p myopenstruct.bob

#the stuff about dsl:
arr = []
arr.instance_eval do
  push(1)
  push(2)
  reverse!
end

p arr

def dsl(obj, &block) 
  obj.instance_eval(&block)
end

dsl(arr) do
  push(1)
  push(2)
  pop
  push(3)
end
p arr

Pizza = Struct.new(:cheese, :pepperoni, :bacon, :sauce)
obj = Pizza.new
dsl(obj) do |pizza|
  pizza.cheese = true
  pizza.sauce = :extra
end
=begin
 The prior example uses a block variable to avoid implicit self syntax that is interpreted 
 by the Ruby interpreter as local variable assignment. If the block variable is omitted, 
 the self keyword is required to clarify that cheese = true is a method call, not local variable assignment. 
=end
 dsl(obj) do
  self.cheese = true
  self.sauce = :extra
end 

class HtmlDsl
  def initialize &block
    instance_eval(&block)
  end
  
  def method_missing name, *args, &block
    puts name, block
    tag = name.to_s
    content = args.first
    @result ||= ''
    @result << "<#{tag}>"
    if block_given?
      instance_eval(&block) #trigger the method calling and then come back to method_missing until there's no block
    else
      @result << "<#{tag}>#{content}</#{tag}>"
    end
    @result << "</#{tag}>"
  end
end
#desired behavior of the DSL:
html = HtmlDsl.new do
  html do
    head do
      title 'yoyo'
    end
    body do
      h1 'hey'
    end
  end
  
end
p html.result

=begin
 about attr_* methods which are private instance methods of Module, so we have to define it which will be in Singleton Class, and 
 the ancestors chain of Singleton class include Module. 
=end

require 'active_support/all'
=begin
 HashWithIndifferentAccess is an ActiveSupport class 
=end
h = HashWithIndifferentAccess.new({:a => "blah"})
p h['a'] #"blah"

hash = {boo: "casper"}
h = hash.with_indifferent_access
p h.class #ActiveSupport::HashWithIndifferentAccess







