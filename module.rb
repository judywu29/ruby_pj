=begin
 multiple inheritenc: using module, mixin , include XXXX
 extend: mix a module's methods into an object while include mixes methods into a class(intsance methods of a class)
 if we use extend on the class: MyClass.extend XXX: means; it becomes the class method MyClass.XXX
   extend: singleton Class methods: on Class
=end

module MyLib

  module ClassMethods
    def class_method
      puts "This method was first defined in MyLib::ClassMethods"
    end
  end
  
  def self.included receiver
    receiver.extend ClassMethods
  end
  
end

class MyClass
  @my_var = 1 # in MyClass, Class instance variable, only accessed by Class, same as @@my_var, but Class variables:
  #but Class variables can be accessed by subclasses and instance methods. and if we defined @@my_var outside of the MyClass, it 
  # would share it in MyClass, because it's defined in Object and MyClass is its subclass
  include MyLib
  
  def self.class_method
    puts @my_var
  end
  def method_one
    # @my_var = 2 # in object
    puts @my_var# it's a new variable, if doesn't assign its value, it's empty
    puts self
    def method_two;puts self; end
  end
end
# 
MyClass.class_method #1
MyClass.new.method_one #2
MyClass.new.method_two
MyClass.class_method #This method was first defined in MyLib::ClassMethods, on class

=begin
 singleton method for obj: class<<obj, obj.extend 
=end

############################################################
module MyModule
  def my_method; puts "from module"; end
end

obj = Object.new
#becomes instance method:
# class<<obj
  # include MyModule
# end
def obj.extend_module
  extend MyModule
end
obj.extend_module #from module: if extend XX is defined in a method, it would be called
# Object.my_method nonono

# obj.my_method #from module: if my_method is self.my_method, then obj cannot call it
#how about class:Object.my_method, it doesn't work, only by itself:
# MyModule.my_method
# include MyModule
# Object.my_method #Class can call my_method, but not self.my_method
#####################################################################################################

#become a Class method: Class extension
class MyClassIncludeModule
  class<<self
    include MyModule
  end
end
MyClassIncludeModule.my_method

class Loan
  def initialize 
    @time = Loan.time_class.now
    puts @time #Mon Apr 06 12:15:50
  end
  def self.time_class
    @time_class || @time_class = Time #class instance variable, only accessed by class itself
  end
end

class FakeTime
  def self.now
    'Mon Apr 06 12:15:50'
  end
end
Loan.instance_eval{ # or class_eval
  @time_class = FakeTime
}
Loan.new

c = Class.new(Array) do
  def my_method
    puts "Hello"
  end
end
MyClass = c
MyClass.new.my_method
another_class = Object.const_get(:MyClass)
another_class.new.my_method #hello

#NewClass is the name of the new class
new_class = Object.const_set(:NewClass, Class.new)
new_class.class_eval do

  define_method :initialize do
    @name = "judy"
  end
  attr_accessor :name
  
end
puts new_class.new.name #judy

# new_class.module_eval %{
  # def initialize
    # @name = "judy"
  # end
  # attr_accessor :name
# }
#eval is private, can only use inside class
# new_class.send :eval, %{
  # def initialize
    # @name = "judy"
  # end
  # attr_accessor :name
# }
# puts new_class.new.name

new_class.instance_eval do 
  @first_name = "Judy" #class level instance variable
  # def human?
    # @first_name  = "Min"
  # end
  
  # attr_accessor :first_name
end

# puts new_class.new.name ##<NewClass:0x007fb5b5175dc8 @name="hello">
# puts new_class.human?
#attr_acccessor is only used for object instance variable, for class instance variable, use instance_variable_get
puts new_class.instance_variable_get("@first_name") #only can use instance_variable_get to get class instance: "Judy"

class Book
  def title
    puts "title is Ruby metaprogramming.."
  end
  
  def lend_to user
    puts "lending to #{user}"
  end
  
  alias :LEND_TO_USER :lend_to
  alias :TITLE :title
end

# Book.lend_to_user #class cannot call instance method
Book.new.LEND_TO_USER "judy" #lending to judy
book = Book.new
#3 methods to define singleton methods:
# eigenclass = class << book
  # def my_singleton_method
    # puts "singleton method is here. "
  # end
 # end
 
 #or 
 # def book.my_singleton_method
  # puts "singleton method is here. "
 # end 
 #or
 book.instance_eval do
    def book.my_singleton_method
      puts "singleton method is here. "
    end
 end
 puts book.my_singleton_method
 puts Book.new.respond_to? :my_singleton_method #false
# puts eigenclass.instance_methods.grep(/my_/)

=begin
 eigenclass: the singleton method cannot live in MyClass, because if it did, all instances of MyClass would share it. 
=end

#only load it when it's called
autoload :Set, "set.rb"
def random_set size
  max = size *10
  set = Set.new
  set<<rand(max) until set.size == size
  return set
end

puts random_set(10).inspect #<Set: {91, 64, 10, 61, 92, 70, 36, 93, 54, 45}>

=begin
 super(), super, to initialize module's instance variable
 
super不带括号表示调用父类的同名函数，并将本函数的所有参数传入父类的同名函数；

super()带括号则表示调用父类的同名函数，但是不传入任何参数； 
=end

module Timeable
  attr_reader :time_created
  def initialize
    @time_created = Time.now
  end
  
  def age
    Time.now - @time_created
  end
end

class Character
  include Timeable
  attr_reader :name
  def initialize name
    @name = name
    super() # Timeable is the superclass and calls its initialize
  end
end

c = Character.new 'Jane'
puts c.time_created #2015-07-31 08:58:52 +1000


################################################################################
class Class
  def included_modules
    @modules ||= []
  end
  
  alias_method :old_new, :new
  
  #call module's initialize methods when new the instances
  #class doesn't have to know which module has included
  def new *args, &block
    obj = old_new *args, &block
    included_modules.each do |mod|
      mod.initialize if mod.respond_to? :initialize
    end
    obj
  end
end

module Initializable
  def self.included mod
    mod.extend ClassMethods
  end
  
  #push self into the array
  module ClassMethods
    def included mod
      if mod.class != Module
        puts "Adding #{self} to #{mod}"
        mod.included_modules << self
      end
    end
  end
end

#similar to inherit from Initializable
module A
  include Initializable
  def self.initialize
    puts "A is initialized"
  end
end

module B
  include Initializable
  def self.initialize
    puts "B is initialized"
  end
end

class BothAAndB
  include A
  include B
end

both = BothAAndB.new
=begin
Adding A to BothAAndB
Adding B to BothAAndB
A is initialized
B is initialized 
=end





##################################################################################



















