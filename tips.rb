def fibonacci max=Float::INFINITY
  return to_enum(__method__, max) unless block_given?
  yield previous = 0
  while (i ||= 1) < max
    yield i
    i, previous = previous + i, i
  end
  # previous
end
p fibonacci(100)
# fibonacci(100) {|i| puts i}

# def fibonacci(n)
  # # return n if (0..1).include? n
  # # fibonacci(n-1) + fibonacci(n-2)
  # n <= 1 ? n : fibonacci(n-1)+fibonacci(n-2)
# end

=begin
0
1
1
2
3
5
8
13
21
34
55
89 
=end
p fibonacci(10) ##<Enumerator: main:fibonacci(100)>

require 'socket'

module SocketClient
  def self.connect(host, port)
    sock = TCPSocket.new(host, port)
    begin
      result = yield sock
    ensure
      sock.close
    end
    result
    rescue Errno::ECONNREFUSED
    end
end
 

SocketClient.connect("localhost", 55555) do |sock|
  sock.write("Hello")
  puts sock.readline
end

puts ("a".."z").include?("ab") #false
puts ("a".."z").cover?("ab") #true

a = %w(a b c D)
p a.map(&:upcase) #["A", "B", "C", "D"]
#collect and map are twins

p a.each(&:upcase) #["a", "b", "c", "D"]

#twins:reduce and inject
p a.reduce(:+) #"abcD"
p a.reduce(&:+) #"abcD"

p a.inject(:+)#"abcD"
p a.inject(&:+)#"abcD"

#don't need do this: 
(5..10).reduce(0) do |sum, value|
  sum+value
end

p (5..10).reduce(:+) #45
p (5..10).reduce(&:+) #45

p (5..10).inject(&:+) #45
p (5..10).inject(&:+) #45

#twins
p (1..8).select{|x| x%2 == 0} #[2, 4, 6, 8]
p (1..8).reject{|x| x%2 == 0} #[1, 3, 5, 7]

#constructing: 想象成收缩
#2 arrays => 1 array => hash
names = ["Arthur", "Ford", "Trillian"]
ids = [42, 43, 44, 45]
id_names = ids.zip(names)# 个数可以不匹配
p id_names #[[42, "Arthur"], [43, "Ford"], [44, "Trillian"], [45, nil]]
id_names = names.zip(ids)
p id_names #[["Arthur", 42], ["Ford", 43], ["Trillian", 44]]
p id_names.to_h #{"Arthur"=>42, "Ford"=>43, "Trillian"=>44}

#destructing: 
params = {:first_name=>"Judy", :last_name=>"wu"}
p params.values #["Judy", "wu"]
p params.keys #[:first_name, :last_name]
p params.each_pair ##<Enumerator: {:first_name=>"Judy", :last_name=>"wu"}:each_pair>
first,last = params.values_at(:first_name, :last_name) #["Judy", "wu"]
p first
p last


class Point
  attr_accessor :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end
  def to_a
    [x, y]
  end
  
  def to_ary
    [x, y]
  end
end

point = Point.new(6,3)
# x, y = *point #* to split: to call to_a to split
x, y = point # call to_ary to be like array
p x #6
p y #3

#如果继承自父类并且不需要对参数进行修改，就用＊来代替这些参数， 不需要知道是什么
# class LoggedReader < Reader
  # def initialize(*)
    # super
    # @logger = Logger.new(STDOUT)
  # end
#   
  # def read(*)
    # result = super
    # @logger.info(result)
    # result
  # end
# end


############conversion methods
#non strict methods:
a = {:foo => 1, :bar => 2 }
p a.to_a          #[[:foo, 1], [:bar, 2]]
p nil.to_a        #[]
p "3".to_i        #3
p "foo".to_i      #0
p nil.to_i        #0
p [1,2,3].to_s    #"[1,2,3]"
p nil.to_s        #""
p nil.to_h        #{}

# strict: to_int, Integer()
USERS = ["Arthur", "Ford", "Trillian"]
def user(id)
  USERS[id.to_i]
  # USERS[id.to_int] #undefined method `to_int'
  # USERS[Integer(id)] # `Integer': can't convert nil into Integer (TypeError)
end
p user(nil) #"Arthur", nil=>0

#to_ary, Array()

#将对象转成integer， string
class Line
  def initialize(id)
    @id = id
  end
  
  def to_int #implicit conversion to integer
    @id
  end
end

# line = Line.new("foo") #`[]': can't convert Line to Integer (Line#to_int gives String) (TypeError)
# names = ["Central", "Circle", "District"]
# p names[line] 

class Response
  def initialize(status, message, body)
    @status, @message, @body = status, message, body
  end
  
  def to_str
    "#{@status} #{@message}"
  end
end

res = Response.new(404, "Not Found", "")
# raise res #404 Not Found (RuntimeError)

#将array转成对象
class Apoint
  attr_accessor :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end
  
  def self.to_proc
    Proc.new{|ary| new(*ary)}
  end
end

a = [[1,5], [4,2]]
p a.map(&Apoint) # to call to_proc (将操作数变成一个block) [#<Apoint:0x007f9ba3926120 @x=1, @y=5>, #<Apoint:0x007f9ba39260d0 @x=4, @y=2>]



###define a class
=begin
 class XXXX  ＃常规地定义一个类， 静态地
 end
 or
 
 XXXX = Class.new(parent)  ＃好处是简单地定义一个子类
 or 
 
 XXXX = Class.new(parent) do ＃好处是： flast scope
 end
 
 XXXX = Object.const_set(class_name.capitalize, Class.new) #好处是： 可以动态地制定类的名字
=end

#############module_function
#module_function: module method, if include the module, it becames as a private instance method of the class
#or use include self
module Foo
  def foo
    p "foo"
  end
  
  module_function :foo
  
  alias :bar :foo
end

Foo.foo
# Foo.bar #undefined method `bar' for Foo:Module

module Foo
  module_function 
  
  def foo
    p "foo"
  end
  
  # module_function :foo
#   
  # alias :bar :foo
end

Foo.foo

class Bar
  include Foo
  
end

# Bar.new.foo #private method `foo' called for

require 'minitest/autorun'
include Minitest::Assertions

a = ["foo", "bar", "baz"]
b = ["food", "bar", "baz"]

puts diff(a.join("\n"), b.join("\n"))
=begin
 --- expected
+++ actual
@@ -1,3 +1,3 @@
-"foo
+"food
 bar
 baz"
Run options: --seed 5629

# Running:



Finished in 0.001485s, 0.0000 runs/s, 0.0000 assertions/s.

0 runs, 0 assertions, 0 failures, 0 errors, 0 skips 
=end

#find the locaiton of a method
require 'set'
array = [1,2,3]
m = array.method(:to_set)
p m.owner #Enumerable
p m.source_location #["/Users/judy/.rvm/rubies/ruby-2.2.1/lib/ruby/2.2.0/set.rb", 690]

class Loan
  attr_reader :instance_time
  def initialize(book)
    @book = book
    # @instance_time = self.class.time #class variable cannot be accessed by instance object, can only be accessed by class
    @instance_time = self.class.gettime #cannot use self(当调用的时候是object， 而不是类， 所以要显示用类名)
  end
  
  def self.gettime
    @time ||= Time.now #给一个机会给外面： 后面可以使用instance_eval打开类来设置这个变量, @time is class variable
  end
end

Loan.instance_eval{
  @time = "Mon Apr 06 12:15:50" #@time is class variable
}
loan = Loan.new("war and peace")
p loan.instance_time

class LoanChild < Loan
  def self.time
    @time = "XXXX"
  end
end
p LoanChild.time #subclasses can get access to @time, class variable

###comparing to @@xxx, Class variable, can be accessed by subclasses and instance methods(don't use it often, unsafe)


class A
  # def self.create_method
    define_method :method_a do
      puts 'method_a is called'
    end
  # end
  # create_method
end
A.new.method_a

class Book
  def title
    puts "title"
  end
  
  def subtitle
    puts "subtitle"
  end
  
  def lend_to user
    puts "Lending to #{user}"
  end
 
  alias :GetTitle :title
  alias :LEND_TO_USER :lend_to
  alias :title2 :subtitle
 
end

b = Book.new
b.LEND_TO_USER "Bill"

=begin
 需求： 只有包含这个module的类才需要进行check， 那意味着，可以用self.included;
 需要使用class macro， 那意味着可以使用extend， 使之变成类方法
 对属性进行validation， 那意味着要重定义attribute= 方法， 在这个方法上进行验证， 验证的操作可以使用block作为参数，在外面去定义 
=end
module CheckedAttributes
  def self.included base
    base.extend ClassMethod
  end
  
  #become class methods, get mixed into the eigenclass
  module ClassMethod
    def attr_checked attribute, &block
      define_method "#{attribute}=" do |value|
        raise "validation failure" unless block.call(value)
        instance_variable_set("@#{attribute}", value) 
      end
      
      define_method "#{attribute}" do
        instance_variable_get("@#{attribute}")
      end
      
    end
  end
end

module AnotherCheckedAttributes
  def attr_checked attribute, &block
    define_method "#{attribute}=" do |value|
      raise "validation failure" unless block.call(value)
      instance_variable_set("@#{attribute}", value)
    end

    define_method "#{attribute}" do
      instance_variable_get("@#{attribute}")
    end

  end
end
class Person
  # include CheckedAttributes
  extend AnotherCheckedAttributes
  
  #class macro:在一个类定义中使用一个类方法：
  attr_checked :age do |v|
    v >= 18
  end
end

person = Person.new
# Person.new.age = 10 #validation failure
person.age = 20
puts "the age of the person is #{person.age}"


def add_checked_attribute(clazz, attribute)
  eval "
    class #{clazz}
      def #{attribute}=(value)
        raise 'Invalid attribute' unless value
        @#{attribute} = value
      end
      
      def #{attribute}
        @#{attribute}
      end
    end
      "
      
end

add_checked_attribute("MyString", :my_attr)
mystring = MyString.new
mystring.my_attr = "Hello"
p mystring.my_attr

def my_method(*args)
  args.map(&:reverse)
end

p my_method('abc', 'xyz', '123') #["cba", "zyx", "321"]

###blank slate: 1. undef_method, 2. inherit from BasicObject
class C
  def method_missing name, *args
    puts "a Ghost method"
  end
  
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^__|respond_to?|method_missing/
  end
end

p C.new.to_s #"#<C:0x007fef450b1378>"



module M
  def my_method
    puts "a class method"
  end
  
  def self.included base
    base.extend MoudleMethod
  end
  
  module MoudleMethod
    def another_method
      puts "another class method"
    end
  end
end

class Eclass
  include M #at the same time, it also extends class methods from M
  @my_class_instance_variable = "some value" # class instance variable
  
  def self.class_attribute
    p @my_class_instance_variable
  end
end
# class << Eclass
  # include M #include 本来是扩展为instance methods， 但是这样却变成了class method
# end


# Eclass.my_method #a class method
Eclass.another_method #another class method
Eclass.class_attribute #"some value"

class << Eclass
  define_method :my_macro do |arg|
    puts %Q{
      #{arg} is argment of my_marco
    }
  end
end

class Eclass
  my_macro :x #class method
end
# Eclass.my_macro(4)

class CleanRoom
  def a_userful_method(x)
    puts x
  end
end

CleanRoom.new.instance_eval {a_userful_method(3)} # use an object as environment in which to evalute a block

puts "eval begins"
File.readlines("a_file_containing_lines_of_ruby.txt").each do |line|
  puts %Q{
    #{line.chomp} ==> #{eval(line)}
  }
end
eval(File.read('a_file_containing_lines_of_ruby.txt'))

puts "eval ends"
=begin
 the content of the file:
1+1
3*2
Math.log10(100)

result: 
 1+1 ==> 2
 3*2 ==> 6
 Math.log10(100) ==> 2.0 
=end

class D
  def initialize
    @x = "a private instance variable"
  end
end
D.new.instance_eval{p @x} #"a private instance variable"
D.instance_eval{p @x} #nil, because there's class instance variable like @x

#store a piece of code and its context in a proc or lambda for evaluation later
class X
  def store(&block)
    @my_code_block = block
  end
  
  def execute
    @my_code_block.call
  end
end

x = X.new
m, n = 1,2
x.store{ m+n }
puts x.execute #3

m,n=1,2
x.store{m+n}
m, n = 3, 4
puts x.execute #7
m,n=5,6
puts x.execute #11

m = 1
x.store{m=2} 
m=3
puts x.execute #2


=begin
 类似于 eval 
=end

def foo
  judy = 1
  binding
end

p eval("judy", foo) #1
judy = 2
p eval("judy", foo) #1 binding to the foo, only the first argument would effect it

p eval("judy = 5 ", foo) #5

p eval("judy", foo) #1

method_to_call  = :reverse
obj = "abc"
puts obj.send method_to_call #"cba"

class FooBar
  
end

FooBar.class_eval do
  define_method :my_method do
    puts "a dynamic method"
  end
end

FooBar.new.my_method #a dynamic method


class MyDynamicProxy
  def initialize target
    @target = target
  end
  
  def method_missing name, *args
    puts %Q{
      result: #{@target.send name, *args}
    }
  end
end

string = MyDynamicProxy.new("this is a string")
string.reverse #gnirts a si siht

#flat scope
class ShareClass
  def an_attribute
    @attr
  end
  
end

sc = ShareClass.new
local_variable = 100

sc.instance_eval do
  @attr = local_variable
end
puts sc.an_attribute #100

class GhostClass
  def method_missing name, *args
    name.to_s.reverse
  end
end

puts GhostClass.new.my_ghost_method #dohtem_tsohg_ym

$INHERITORS = []
class HookClass
  def self.inherited subclass
    $INHERITORS << subclass
  end
  
end

class AClass < HookClass
end

class BClass < HookClass
end

class CClass < BClass
end

p $INHERITORS #[AClass, BClass, CClass]

module Kernel
  def a_method
    puts "a kernel method"
  end
end

a_method #a kernel method

class LazyClass
  def attribute
    @attri ||= "some value"
  end
end
lc = LazyClass.new
puts lc.attribute #some value


def BaseClass name
  name == "string" ? String : Object
end

class MimicClass < BaseClass "string"
  attr_accessor :an_attribute
end

mimic = MimicClass.new
mimic.an_attribute = 1
puts mimic.an_attribute #1

#MonkeyPatch
puts "abc".reverse
class String
  def reverse
    "override"
  end
end
puts "abc".reverse #override

#collect method arguments into a hash
def my_method(args)
  args[:arg2]
end

puts my_method(:arg1=>'A', :arg2=>'B', :arg3=>'C') #B

module MyNamespace
  class Array
    def to_s
      "my class"
    end
  end
end

p Array.new #[]
p MyNamespace::Array.new ##<MyNamespace::Array:0x007fc85a837e60>

x=nil
y = x || "a value"
puts y #a value

#obejct extension: mixin
class MyClass
  
end

obj = MyClass.new

module MToExtend
  def my_method
    puts "a singleton method"
  end
end

#object extension: becomes a singleton method
class << obj
  include MToExtend
end
# obj.my_method
#object extension
# obj.extend MToExtend
obj.my_method
p obj.singleton_methods #[:my_method]
=begin
They are different when they are used in a class
Extend a module inside a class will add the instance methods defined in the module to the extended class.

The Include will add the instance methods defined in the module to the instances of the class including the module.
=end

# MyClass.include MToExtend
# obj.my_method
# Include is for adding methods to an instance of a class and extend is for adding class methods.extend doesn't have a hook
=begin
 If you have a class and module, including module in class gives instances of 
 class access to objects to module's methods. Or you can extend class with module giving the 
 class  access to module's methods. But also you can extend an object with 
   o.extend Mod. In this case the individual object gets module's methods even though all 
     other objects with the same class as o do not. 
=end
# class << obj
  # extend(MToExtend)  #my_method becomes a private method: 
  # # include MToExtend #public method
# end
# 
# # obj.extend MToExtend #still public method
# obj.my_method

$global_variable = 0
class DipatchClass
  def my_first_method
    $global_variable += 1
  end
  
  def my_second_method
    $global_variable += 2
  end
end

# dynamically disaptch to some methods of the object, 不一定要一个proxy的类来派发
obj = DipatchClass.new
obj.methods.each do |m|
  obj.send m if m=~ /^my_/
end

puts $global_variable #3

#execute untrusted code in a safe environment
#$SAFE: to disallow certain potentially dangerous operations
def sandbox(&block)
  proc{ #clean room
    $SAFE = 1 # 1: can delete a File, 2: disallow most file-related operations, 数字越大，越不能做什么
    yield
  }.call
end

begin
  sandbox{File.delete 'a_file'}
rescue Exception => ex
  p ex           ##<SecurityError: Insecure operation `delete' at level 2>
end

a_variable = 1
p defined? a_variable #"local-variable"

module MyModule
  b_variable = 1
  p defined? a_variable #nil
  p defined? b_variable #"local-variable"
end

p defined? a_variable #"local-variable"
p defined? b_variable #nil


#yield self, current object, a good way to initialize a object with block
class Person
  attr_accessor :name, :surname
  
  def initialize
    yield self if block_given?
  end
end

joe = Person.new do |p|
  p.name = "Joe"
  p.surname = "Smith"
end

p joe.name
p joe.surname

#shift: first element, pop: the last elem, push: insert as the tail
p ['a', 'b', 'c'].push('d').shift.upcase.next #'B'
p ['a', 'b', 'c'].push('d').shift.tap{|x| puts x}.upcase.next #a

#convert a symbol to Proc
p [1,2,3,4].map(&:even?) #to every elem #[false, true, false, true]
=begin
 class Symbol
   def to_proc
     Proc.new{|x| x.send(self)} :even? => :even?.to_proc, self: symboo
   end
 end
    
    &: to_proc => &:even? = &:even?.to_proc
=end

class MimicClass
  attr_accessor :my_attr
  def initialize_attributes
    # my_attr = 10 #return nil, local variable
    self.my_attr = 10
  end
end

mm = MimicClass.new
mm.initialize_attributes
p mm.my_attr

class NilClass
  def elements
    @a ||= [] #lazy instance variable = def initialize; @a = []; end + def elements; @a; end
  end
end

def my_args_method(*args)
  p args
end

my_args_method(1, '2', 'three') #[1, "2", "three"]
my_args_method(:a=>'x', :b=>3, :c=>'Y') #[{:a=>"x", :b=>3, :c=>"Y"}]

def my_args_method_forhash(args)
  p args
end

my_args_method_forhash(:a=>'x', :b=>3, :c=>'Y') #{:a=>"x", :b=>3, :c=>"Y"}, for hash, doen'st need *, * is for array

#add method in a safe way
class Module
  def rake_extension method
    if method_defined? method
      raise "Possible conflict with Rake extention: #{self}##{method} already exists"
    else
      yield 
    end
    
  end
end

class String
  rake_extension "abc" do
    def abc(newext='')
      puts "add an new method"
    end
  end
  
  #will raise an exception
  # rake_extension "reverse" do
    # def reverse(newext='')
      # puts "add an new method"
    # end
  # end
end
"a string".abc

#alias_method_chain， 好处是，两个方法都可以单独调用， greet_without_log, greet_with_log(接口是greet), 
class MyClass
  def greet
    puts "hello"
  end
  
  def greet_with_log
    puts "Calling method..."
    greet_without_log
    puts "...Method called"
  end
  
  alias :greet_without_log :greet
  alias :greet :greet_with_log
end

my_class = MyClass.new
my_class.greet
my_class_copy = Object.const_get("MyClass").new
p my_class, my_class_copy
=begin
Calling method...
hello
...Method called 
=end

MyClass.new.greet_without_log #hello

# require 'net/http'
# require 'uri'
# 
# module Net
  # class HTTP
    # def HTTP.get_with_headers(uri, headers=nil)
      # uri = URI.parse(uri) if uri.respond_to? :to_str
      # start(uri.host, uri.port) do |http|
        # return http.get(uri.path, headers)
      # end
    # end
  # end
# end
# 
# res = Net::HTTP.get_with_headers('http://www.google.com/', {'Accept-Language'=>'en'})
# s = res.body.size
# puts res.body[s-200..s-140]
# =begin
 # ;charset=utf-8">
# <TITLE>302 Moved</TITLE></HEAD><BODY>
# <H1>30 
# =end
# 
# #send a SMS message
# uri = URI.parse('https://api.modicagroup.com/rest/gateway/messages')
# json_payload = '{"content": "hello world", "destination": "+64211234567"}'
# 
# #create http object, request object(default it's get, and if we have to set use_ssl)
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# request = Net::HTTP::Post.new(uri.request_uri)
# request.basic_auth('username', 'password')
# request.body = json_payload
# response = http.request(request)
# 
# puts 'HTTP %s' % response.code #HTTP 401
# 
# puts response.body #{"status": 401, "message": "Unauthorized"}
# 
# 
# #get a SMS message
# uri = URI.parse('https://api.modicagroup.com/rest/gateway/messages/message_id')
# 
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true
# request = Net::HTTP::Get.new(uri.request_uri)
# request.basic_auth('username', 'password')
# response = http.request(request)
# 
# puts 'HTTP %s' % response.code #HTTP 401
# 
# puts response.body 
=begin
 {"status": 404, "message": "Not Found. You have requested this URI [/rest/gateway/messages/message_id] 
   but did you mean /rest/gateway/messages/<int:id> or /rest/gateway/messages ?"} 
=end

#fetches the homepage and prints out the first part of it:
# require 'open-uri'
# puts open('http://www.oreilly.com/').read(200)
=begin
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>O'Reilly Media - Technology Books, Tech Conferences, IT Courses, News</ti 
=end

#use net/http
#create URI objects from URL strings(hostname, port and path together)
#################################
# response = Net::HTTP.get(URI.parse("http://www.oreilly.com"))
# puts response #return the whole page, no code, body methods for this way
#######################################
# response = Net::HTTP.get_response(URI.parse("http://www.oreilly.com/about/"))
#response code, http response headers..
########################################
#same the above way:more complicated:
# uri = URI.parse('http://www.oreilly.com/about/')
# http = Net::HTTP.new(uri.host, uri.port)
# request = Net::HTTP::Get.new(uri.request_uri)
# response = http.request(request)
#############################################
# puts response.code #200
# puts response.body.size #31030
# puts response['Content-type'] #text/html; charset=utf-8
# puts response.body[0, 200]
# p response['Server'] #Apache
# puts "keys: "
# response.each_key{|key| puts key}
=begin
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>



<style type="text/css">
li.GlobalNavInfo.right { width: 145px; }
</style
keys:of the header
server
last-modified
content-type
vary
cache-control
expires
date
content-length
connection
=end
#read fixed length structure
# Net::HTTP.get_response('www.oreilly.com', '/about/') do |response|
  # response.read_body do |segment|
    # puts "Received segment of #{segment.size} bytes!"
  # end
# end
=begin
 Received segment of 1102 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 2800 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 2800 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1400 bytes!
Received segment of 1928 bytes! 
=end

# uri = URI.parse("https://www.donotcall.gov/")
# request = Net::HTTP.new(uri.host, uri.port)
# # response = request.get("/")
# 
# require 'net/https'
# request.use_ssl = true
# # request.ca_path = "/etc/ssl/certs"
# # request.verify_mode = OpenSSL::SSL::VERIFY_PEER #:in `connect': SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (OpenSSL::SSL::SSLError)
# # request.verify_mode = OpenSSL::SSL::VERIFY_NONE #suppresses some warning
# response = request.get("/")
# puts response.body.size #8771
# 
# uri = URI.parse('http://www.google.com/')
# request = Net::HTTP::Get.new(uri.path)
# ['en_us', 'en', 'en_gb', 'ja'].each do |language|
  # request.add_field('Accept-Language', language)
# end
# 
# puts request['Accept-Language']
# 
# Net::HTTP.start(uri.host, uri.port) do |http|
  # response = http.request(request)
# end
# 
# puts URI.parse('https://www.example.com:6060').scheme
# puts URI.parse('https://www.example.com:6060').host
# puts URI.parse('https://www.example.com:6060').port
# puts URI.parse('https://www.example.com/a/file.html').path
# =begin
 # https
# www.example.com
# 6060
# /a/file.html 
# =end
# 
# p URI.split('https://www.example.com/a/file.html') 
# #["https", nil, "www.example.com", nil, nil, "/a/file.html", nil, nil, nil]
# p URI::HTTP.component #[:scheme, :userinfo, :host, :port, :path, :query, :fragment]
# p URI::MailTo.component #[:scheme, :to, :headers]
# 
# class URI::Generic
  # def dump
    # component.each do |m|
      # puts "#{m}: #{send(m).inspect}"
    # end
  # end
# end
# # url = 'http://leonardr:pw@www.subdomain.example.com:6060' + 
# # '/cgi-bin/mycgi.cgi?key1=value1#anchor'
# 
# #or
# url = 'ftp://leonardr:pw@www.subdomain.example.com:6060' + 
# '/cgi-bin/mycgi.cgi?key1=value1#anchor'
# URI.parse(url).dump
# =begin
# scheme: "http"/"ftp"/"mailto"/"ldap" < URI::Generic (superclass)
# userinfo: "leonardr:pw"
# host: "www.subdomain.example.com"
# port: 6060
# path: "/cgi-bin/mycgi.cgi"
# query: "key1=value1"
# fragment: "anchor" 
# =end
# 
# require 'cgi'
# cgi = CGI.new("html5")
# cookie = cgi.cookies['rubycookbook']
# cookie = CGI::Cookie.new('rubycookbook','hits=0',"last=#{Time.now}") if cookie.empty?
# hits = cookie.value[0].split('=')[1]
# last=cookie.value[1].split('=')[1]
# 
# cookie.value[0] = "hits=#{hits.succ}"
# cookie.value[1] = "last=#{Time.now}"
# 
# header = {
  # 'status' => 'OK',
  # 'cookie' => [cookie],
  # 'Refresh' => 2,
  # 'Recipe Name' => 'Setting HTTP Response Headers',
  # 'server' => ENV['SERVER_SOFTWARE']
# }
# 
# cgi.out(header) do
  # cgi.html('PRETTY' => ' ')do
   # cgi.head{cgi.title{'Setting HTTP Response Headers'}} +
   # cgi.body do
     # cgi.p('Your headers:') + 
     # cgi.pre{cgi.header(header)} + 
     # cgi.pre do
       # "Number fo times your browser hit this cgi: #{hits}\n" +
       # "last connected: #{last}"
     # end
   # end
 # end
# end

class Array
  def quick_sort
    return [] if self.empty?
    x, *a = self
    left, right = a.partition{|t| t < x}
    left.quick_sort + [x] + right.quick_sort
  end
end
arr = [7,4,2,5,1,8, 0, 9]
p arr.quick_sort
p arr

class MyTestClass
  def setattr
    @input ||= 5
  end
  def printattr
    p @input
  end
end
testclass = MyTestClass.new
testclass.instance_eval{@input = 10}
testclass.printattr #10
