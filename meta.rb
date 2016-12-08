#########################################################################

class Class
   def hierarchy
     (superclass ? superclass.hierarchy : [])<<self
   end
end

# puts Array.hierarchy.inspect #[BasicObject, Object, Array]

class MyArray < Array
  attr_reader :v2

  @v2 = 2
  def my_method
    @v = 1
  end
end
a = MyArray.new
p MyArray.ancestors.reverse[1..-1] #[MyArray, Array, Enumerable, Object, Kernel, BasicObject], [Kernel, Object, Enumerable, Array, MyArray]

# puts a.my_method
# puts a.v2
# puts MyArray.v2
puts a.instance_variables.inspect #[:@v], #if my_method is not called, @v is not a's instance variable
puts MyArray.instance_variables.inspect #[:@v2] the instance_variable of Class

puts MyArray.hierarchy.inspect #[BasicObject, Object, Array, MyArray]
puts MyArray.superclass #array

puts String.superclass.inspect #Object

#ancestor chain includes the modules the class includes while super class doesn't include
#method lookup will traverse the ancestor chain
puts String.ancestors.inspect #[String, Comparable, Object, Kernel, BasicObject]
puts Array.ancestors.inspect #[Array, Enumerable, Object, Kernel, BasicObject]
puts MyArray.ancestors.inspect #[MyArray, Array, Enumerable, Object, Kernel, BasicObject]
puts Object.ancestors.inspect #[Object, Kernel, BasicObject]

#########################################################################
=begin
because all of the instance_methods are defined in Class, shared by all of the objects/instances
while variables: related to objects/classes, each object may have different variables
  
for object => methods, private_methods, singleton_methods(defined by a singleton class)
for Class  => instance_methods(public/protected), private_instance_methods, methods(class methods)
   
can use Object.private_methods.include? :define_method
but cannot use respond_to? only search the public/protected methods

Object.instance_methods #only on Class
Object.new.instance_methods
NoMethodError: undefined method `instance_methods'

 => [:nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, 
   :dup, :itself, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, 
   :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, 
   :private_methods, :public_methods, :instance_variables, :instance_variable_get, 
   :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, 
   :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?, :extend, 
   :display, :method, :public_method, :singleton_method, :define_singleton_method, 
   :object_id, :to_enum, :enum_for, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__] 
   
  They are the same: 
Object.new.methods
 => [:nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, 
   :dup, :itself, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, 
   :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, 
   :private_methods, :public_methods, :instance_variables, :instance_variable_get, 
   :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, 
   :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?, :extend, 
   :display, :method, :public_method, :singleton_method, :define_singleton_method, 
   :object_id, :to_enum, :enum_for, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__] 
   
   
   Fixnum.singleton_methods
    => [] 
    
    2.2.1 :008 > Object.method_defined? :inspect
 => true 
2.2.1 :009 > Object.respond_to? :inspect
 => true

String.private_instance_methods.sort
 => [:Array, :Complex, :Float, :Hash, :Integer, :Rational, :String, :__callee__, :__dir__, :__method__, :`, 
   :abort, :at_exit, :autoload, :autoload?, :binding, :block_given?, :caller, :caller_locations, :catch, 
   :default_src_encoding, :eval, :exec, :exit, :exit!, :fail, :fork, :format, :gem, :gem_original_require, 
   :gets, :global_variables, :initialize, :initialize_clone, :initialize_copy, :initialize_dup, :irb_binding, 
   :iterator?, :lambda, :load, :local_variables, :loop, :method_missing, :open, :p, :print, :printf, :proc, 
   :putc, :puts, :raise, :rand, :readline, :readlines, :require, :require_relative, :respond_to_missing?, 
   :select, :set_trace_func, :singleton_method_added, :singleton_method_removed, :singleton_method_undefined, 
   :sleep, :spawn, :sprintf, :srand, :syscall, :system, :test, :throw, :trace_var, :trap, :untrace_var, :warn] 
   
2.2.1 :012 > String.new.autoload?
NoMethodError: private method `autoload?' called for "":String   
=end
#########################################################################

class Object
  def my_methods_only
    my_super = self.class.superclass
    return my_super ? (methods - my_super.instance_methods) : methods
  end
end
s = ''
puts s.methods.size #169
puts Object.instance_methods.size #57
puts s.my_methods_only.size #112

def s.singleton_method
end
puts s.methods.size 
puts Object.instance_methods.size
puts s.my_methods_only.size

puts s.singleton_methods.inspect #[:singleton_method]

class Object
  def new_object_method
  end
end
puts s.methods.size #170
puts Object.instance_methods.size #58
puts s.my_methods_only.size #112

class MyString < String
  def my_string_method
  end
end
puts MyString.new.my_methods_only.inspect #[:my_string_method]


#########################################################################
=begin
 alias 
=end

class Multiplier
  def double_your_pleasure pleasure
    pleasure * 3
  end
end

#define new API: 
Multiplier.class_eval do
  alias :double_your_pleasure_BUGGY :double_your_pleasure
  def double_your_pleasure pleasure
    pleasure *2
  end 
end

puts Multiplier.new.double_your_pleasure 6  #12
puts Multiplier.new.double_your_pleasure_BUGGY 6 #18

#########################################################################

#########################################################################
=begin 
hook methods/callback methods: 
 keep track of methods when they are added, removed or undefined
 keep track of modules when they are included 
=end

class Tracker
  def important
    "this is an important method"
  end
  
  def self.method_added sym
    if sym == :important
      raise 'The "important" method has been redefined'
    else
      puts %{Method "#{sym}" was defined}
      
    end
  
  end
  
  def self.method_removed sym
    if sym == :important
      raise 'The "important" method has been removed'
    else
      puts %{Method "#{sym}" was removed}
      
    end
  end
  
  def self.method_undefined sym
    if sym == :important
      raise 'The "important" method has been undefined'
    else
      puts %{Method "#{sym}" was undefined}
      
    end
  end
  #######################################################???cannot understand
  def self.include_hook mod
    puts %{"#{mod}" was included in #{self}}
  end
end

Tracker.class_eval do  #Method "new_method" was defined
  def new_method
    puts 'This is an new method.'
  end
  # undef :important #`method_undefined': The "important" method has been undefined
end

#########################################################################

#########################################################################
=begin
 check if hook methods have defined the necessary instance variables
 2 ways: 1. check instance_variables 2. use respond_to?
=end
#这里是交叉比较两个array, 查找参数中的变量是否在instance variables 之中
class Object
  def must_have_instance_variables *args
    vars = instance_variables.inject(Hash.new){|hash, var| hash[var] = true; hash}
    p vars
    args.each do |arg|
      unless vars[arg]
        raise "Instance_variable: #{arg} doesn't exist. "
      end
    end
  end
  
  #check methods:
  def must_support *args
    args.each do |arg|
      unless respond_to? arg
        raise ArgumentError, %{Must support "#{arg}"}
      end
    end
  end
end

class Request
  def initialize
    #gather_parameters
    # must_have_instance_variables :action, :user, :authenication
  end
end

obj = "a string"
obj.must_support :to_s, :size, "+".to_sym
# obj.must_support "-".to_sym #must_support': Must support "-" (ArgumentError)

#########################################################################

#########################################################################
=begin
 method_missing, always define respond_to? usually define the method_missing on the wrapper object
and call/forward the method from/to the wrapped object 

#dynamically do something with some pattern(doing the similar things), no need to define a method
class Fixnum
  def method_missing m, *args
    if args.size > 0
      raise ArgumentError.new "wrong number of arguments #{args.size} for 0"
    end
    match = /^plus_([0-9]+)$/.match m.to_s
    puts match.inspect ##<MatchData "plus_5" 1:"5">
    puts match.captures.inspect #["5"] #captures like $1, $2 which are variables
    if match
      self + match.captures[0].to_i
    else
      raise NoMethodError.new "undefined method '#{m}' for #{inspect}:#{self.class}"
    end
  end
  
  def respond_to? m
    super or (m.to_s =~ /^plus_([0-9]+)$/) != nil #^: start, $:end
  end
  
end

puts 4.plus_5 #9
puts -1.plus_2 #1

# 100.minus_3 #`method_missing': undefined method 'minus_3' for 100:Fixnum

puts 25.respond_to? :plus_20 #true if redefined the respond_to?

#setter: getter
class MyOpenStruct
  def initialize
    @attributes = {}
  end
  
  def method_missing name, *args
    puts name.class #symbol
    puts name, args.inspect #first_attribute=, ["Hello world"]
    attribute = name.to_s
    if attribute =~ /=$/
      @attributes[attribute.chop] = args[0] 
     else
       @attributes[attribute]
     end
  end
  
  def respond_to? name
    attribute = name.to_s
    super or ((attribute =~ /=$/) != nil and @attributes.include?(attribute.chop) )
  end
end

struct = MyOpenStruct.new
struct.first_attribute = "Hello world"
puts struct.first_attribute 
puts struct.respond_to? :first_attribute= #false, and return true after defined respond_to?

#########################################################################

#########################################################################
=begin
 eval, binding:  all of the variables are accessable from that context where binding is 
=end

def foo
  x =1
  binding
end

saving_binding = foo

p eval "x", saving_binding #1, foo block is the context
x = 2
p eval "x", saving_binding #1
p eval "x=5", saving_binding #5: the first argument would effect the value in the context(foo)

def foo2 my_binding
  eval "x", my_binding
end

def bar
  x =100
  foo2 binding #bing here: inside bar
end

p bar #100, the binding in the bar

def foo my_binding
  x = 200
  eval "x", my_binding
end

p bar #still 100, x is bound to bar

x = 100
block_var = lambda{x}
def foo3 blk
  blk.call
end

p foo3 block_var #100

class<<Object
  def my_method name, klass
    define_method name {eval "@#{name} ||= #{klass}.new"}
  end
end


class<<Object
  def attr_init name, klass
    eval "define_method(name) {@#{name} ||= #{klass}.new}"
  end
end
#第二种写法只需要调用一次eval方法，而不是在每次进行方法定义时都去重新调用eval。

class Object
  private
  def set_instance_variables binding, *variables
    variables.each do |var|
      instance_variable_set("@#{var}", eval("#{var}", binding))
    end
  end
end

class RGBColor
  
  def initialize red=0, green=0, blue=0
    puts local_variables.inspect # [:red, :green, :blue]
    set_instance_variables(binding, *local_variables)
  end
end

rgb = RGBColor.new 10, 200, 300
p rgb.inspect #"#<RGBColor:0x007f9541077e88 @red=10, @green=200, @blue=300>"

#########################################################################

#########################################################################
=begin
 define_method 
=end

class GeneratedFetcher
  def fetch how_many
    puts %{Fetching #{how_many ? how_many : "all"}}
  end
  
  [["one", 1], ["ten", 10], ["all", nil]].each do |name, number|
    define_method("fetch_#{name}") {fetch number } # if use {}, has to use braces for arguments, if use do/end, no need
  end
  
end

GeneratedFetcher.new.fetch_one #Fetching 1

define_method "call_with_args" do |*args, &block|
  block.call *args
end

call_with_args(1,2){|n1,n2| p n1+n2} #3
puts call_with_args("mammoth") {|x| x.upcase} #MAMMOTH, if there's block behine, braces have to be added

#########################################################################

#########################################################################
=begin
 Aspect oriented: wrap: pre/post 
=end

require 'aspectr'
class Verbose < AspectR::Aspect
  
  def describe(method_sym, object, *args)
    %{#{object.inspect}.#{method_sym}(#{args.join(",")})}
  end
  
  def before(method_sym, object, return_value, *args)
    puts %{about to call #{describe(method_sym, object, *args)}}
  end
  
  def after(method_sym, object, return_value, *args)
    puts %{#{describe(method_sym, object, *args)} has returned} + return_value.inspect
  end
end

verbose = Verbose.new
stack = []
verbose.wrap(stack, :before, :after, :push, :pop)

# stack.push(10)
# stack.pop(10)

#########################################################################

#########################################################################
=begin
 DSL: read file and exeute it 
=end
# def event name
  # puts "ALERT: #{name}" if yield
# end

# Dir.glob('dsl.rb').each{|file| load file, true} #ALERT: we're earning wads of money

# def event name, &block
  # @events[name] = block
# end
# 
# def setup &block
  # @setups << block
# end

=begin
Setting up sky
Setting up mountains
ALERT: the skky is falling
Setting up sky
Setting up mountains
ALERT: it's getting closer 
=end
# Dir.glob('dsl.rb').each do |file|
  # @events = {}
  # @setups = []
  # load file, true
  # @events.each_pair do |name, event|
    # # env = Object.new
    # @setups.each do |setup|
      # setup.call
      # # env.instance_eval &setup #do something(block) on the object, give the block a context to execute/run
    # end
    # # puts "ALERT: #{name}" if env.instance_eval &event
    # puts "ALERT: #{name}" if event.call
  # end
# end

lambda{
  setups = []
  events = {}
  Kernel.send :define_method, :setup do |&block|
    setups << block  
  end
  
  Kernel.send :define_method, :event do |name, &block|
    events[name] = block
  end
  
  # define_method :each_setup do |&block|
    # setups.each do |setup|
      # block.call setup
    # end
  # end
#   
  # define_method :each_event do |&block|
    # events.each_pair do |name, event|
      # block.call name, event
  # end
  
  Kernel.send :define_method, :each_setup do
    setups.each do |setup|
      setup.call
    end
  end
  
  Kernel.send :define_method, :each_event do
    events.each_pair do |name, event|
      event.call
      puts "ALERT:#{name}"
    end
  end
    
  
}.call
# 
# 
# Dir.glob('dsl.rb').each do |file|
  # load file, true
  # each_event do |name, event|
    # env = Object.new
    # each_setup do |setup|
      # env.instance_eval &setup
    # end 
    # puts "ALERT:#{name}" if env.instance_eval &event
  # end
  
  Dir.glob('dsl.rb').each do |file|
  load file, true
  each_setup #don't need env as binding, methods/block carry their own context
  each_event
  end
  
#########################################################################

#########################################################################
=begin
 eval: put all of the commands/code into string, eval can execute it
 irb=>>eval(code processor)
 eval statements, @binding, file, line
 
 binding: get access to the scope
 proc and methods carry their own context, but symbols and string of code don't
 
 shortcoming: code injection attack: string of code+>>>>>>>>>>>>use dynamic dispatch(send)
 or use $SAFE, Tainted objects: reads from web forms, files, the command line or even a system variable
 easier said than done
=end

array = [10,20]
element = 30
eval "array<<element" 
puts array.inspect #[10, 20, 30]

###############binding###############
class MyBindClass
  def my_method
    @x = 1
    binding #create a binding
  end
end

b = MyBindClass.new.my_method
p eval "@x", b #1 access to that scope inside class#method

class AnotherClass
  def my_method
    eval "self", TOPLEVEL_BINDING
  end
end

p AnotherClass.new.my_method #main

array = ['a', 'b', 'c']
x = 'd'
array.instance_eval "self[1] = x" #it's unneccessary be a block, can be a string "" like eval
puts array.inspect #["a", "d", "c"]

# $SAFE = 1
# user_input = "User input: #{gets()}"
# eval user_input #Insecure operation - eval (SecurityError)

# require 'erb'
# erb = ERB.new(File.read 'template.rhtml')
# erb.run

=begin
 <p>
  <strong>Wake up!</strong>
  It's a nice sunny Sunday.
</p> 
=end

#########################################################################

#########################################################################
=begin
 Class Extension Mixin: plus hook methods(self.inherited)
 where you define class methods by including a module in the eigenclass in stead of in the class itself. 
 (the module would be wrapped by a anonymous class as parent), the methods in the module become instance methods in 
 the eigenclass, which also makes them class methods in the class

 requirements: 
 1. include a CheckedModule, and not for all of the classes, only for the class who include this module:
 use self.included base hooked method, 
 2. has to use attr_checked class macro: define a attr_checked method in the module. put in the hook method, 
 or use base.extend AnotherModule(the attr_checked is defined inside)
 3. check the attributes and use the block to validate the attributes:
 the method has to use block as argument; and use open class: define 2 methods: attribute= and attribute, 
 overrie the methods: setter, getter: use instance_variable_set and instance_variable_get
 to set and get the variable
=end
# module CheckedModule
  # def self.included base
    # base.extend ClassMethod
  # end
#   
  # module ClassMethod
    # def attr_checked attribute, &validation
      # define_method "#{attribute}=" do |value|
        # raise "Invalid attribute" unless validation.call value
        # instance_variable_set "@#{attribute}", value
      # end
#       
      # define_method attribute do
        # instance_variable_get "@#{attribute}"
      # end
    # end
  # end
# end

#or just define additional methods directly in Mixin module, these methods would then become instance methods of the including class
#在对attribute赋值的时候进行验证，可以认为是对setter方法进行重载， 相当于对setter添加了validation功能
#类似于定义了一个class macro， 类似于validates in ActiveRecord
module CheckedAttributes
  def self.included base
    base.extend ClassMethod
  end
  
  module ClassMethod
    def attr_check attr, &validation
      define_method "#{attr}=" do |value|
        raise 'Invalid attribute' unless validation.call value
        instance_variable_set "@#{attr}", attr
      end
      
      define_method "#{attr}" do
        instance_variable_get "@#{attr}"
      end
    end
  end
end


#定义一个attribute并且对attribute进行验证的方式， module自动对其进行属性setter方法定义和进行验证。
class Person
  include CheckedAttributes
  
  attr_check :age do |v|
    v >= 18
  end
end

p = Person.new
# p.age = 10 #Invalid attribute (RuntimeError)
# puts p.age
p.age= 20   #instance_methods
puts p.age #20
################################include#############################
module M
   def self.moudle_method #singleton method
     p "called from M"
   end
end
class C
  # def self.include *modules #private method
    # puts "called: C.include(#{modules})"#called: C.include([M])
    # super #after include, M becomes its parent, so C has to call it's parent, like inheritence
  # end
  include M
  #call method from parent class/module, because module_method is singleton method and only belongs to M, 
  #so it can only be accessed by it's child class
  def self.class_method 
    M.moudle_method
  end
  
end
C.class_method #undefined method `my_method' because it doesn't call super, so C doesn't include M anymore
#########################################################################

#########################################################################
=begin
 prevent monkey patches 
=end
# module ExtensionModule
  # def extension(method)
    # if method_defined? method #check method is included
      # p 'possible conflict with extension'
    # else
      # yield
    # end
#     
  # end
# end
# 
# class MyString
#   
  # include ExtensionModule
  # def output
    # puts "test extension"
  # end
#   
#   
# end
# MyString.new.extension "output" do
   # define_method :output do
      # p 'define another extension'
    # end
# end


# require 'activerecord'
# # ActiveRecord::Base
# 
# class MyActiveRecordClass
#   
  # def save;end
  # def save!; end
  # def new_record?; true;end
#   
  # include ActiveRecord::Validations
  # attr_accessor :attr
  # validates_length_of :attr, :minimum=>4
# end
# 
# obj = MyActiveRecordClass.new
# obj.attr = 'test'
# p obj.valid?

# require 'rubygems'
# require 'active_record/base'
# require 'sqlite3'
# ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
                                        # :database => "dbfile"
#                                         
# ActiveRecord::Base.connection.create_table :task do |t|
  # t.string :description
  # t.boolean :completed
# end
# 
# class Task < ActiveBase::Base; end
# task = Task.new
# task.description = 'clean up garage'
# task.completed = true
# task.save

def define_methods
  shared = 0
  
  define_method :counter do #if use def, it cannot use the shared
    p shared
  end
  
  Kernel.send :define_method, :inc do 
    p shared+1
  end
end

##################################comparing the speed#######################
require 'benchmark'

Foo = Class.new
Bar = Class.new

t = 100000

Benchmark.bm do |x|
  x.report('def') {t.times{Foo.class_eval { def a; end}}}
  x.report('define_method'){t.times{Bar.class_eval{define_method(:a){}}}}
end

=begin
                user     system      total        real
def            0.190000   0.000000   0.190000 (  0.197784)
define_method  0.290000   0.010000   0.300000 (  0.296416) 
=end

#factory method, or proxy
class Company
  
  def initialize name, service_tel
    @name = name
    @service_tel = service_tel
  end
  
  def release_new_product product_name
    product = Object.const_set(product_name.capitalize, Class.new) #class name has to be capitalized
    company = self
    #use block
    # product.class_eval do
      # define_method :initialize do
        # @company = company
        # @name = product_name
      # end
      # attr_accessor :company, :name
    # end
    
    #or use string of code:
    code = %Q{
      define_method :initialize do
        @company = company
        @name = product_name 
      end
      attr_accessor :company, :name
    }
    product.class_eval code
  end
  
end

company = Company.new('Apple', '123-123456')
company.release_new_product('iphone6')
p Iphone6.new.name
p Iphone6.new.company
=begin
 "iphone6"
#<Company:0x007ff0aa88f110 @name="Apple", @service_tel="123-123456"> 
=end

# module Base
  # def show
    # puts "You came here"
  # end
# end
# 
# class Car
  # extend Base
# end
# 
# class Bus
  # include Base
# end
# 
# Car.show
# Bus.new.show

#同时使用extend and include
module Base
  def show                # instance method
    puts "You came here"
  end
  
  def self.included base
    def base.call           #define a class method
      puts "I am strong"
    end
    base.extend ClassMethod #extend class method
    
  end
  
  module ClassMethod
    def hello
      puts "hello baby"
    end
  end
end

class Bus
  include Base
end

Bus.new.show
Bus.hello
Bus.call

require 'uri'
#conventions: 1. put the class file into the folder(apdater) 2. name the class name as HttpAdapter
#it's easy to add adapter, just follow the above 2 conventions
# class MessageGateway
  # def initialize
    # load_files "adapter"
    # load_files "auth"
  # end
#   
  # def load_files dir_name
    # full_path = File.join(File.dirname(__FILE__), dir_name, "*.rb") # __FILE__: current source file
    # Dir.glob(full_path).each do |file|
      # require file
  # end
#   
  # end
#   
  # def process_message(message)
    # return unless authorized? message
    # adapter = adapter_for(message)
    # adapter.send message
  # end
#   
  # def adapter_for message
    # protocol = URI.parse(message).scheme.downcase
    # adapter_name = "#{protocol.capitalize}Adapter"
    # adapter_class = self.class.const_get(adapter_name)
    # adapter_class.new
  # end
#   
  # def camel_case string
    # tokens = string.split(".")
    # tokens.map!(&:capitalize)
    # tokens.join('Dot')
  # end
#   
  # def authorize_for message
    # to_host = URI.parse(message).host || 'default'
    # authorizer_class = camel_case(to_host) + "Authorizer"
    # authorizer_class = self.class.const_get(authorizer_class)
    # authorizer_class.new
  # end
#   
  # def worm_case string
    # tokens = string.split('.')
    # tokens.map!(&:downcase)
    # tokens.join('_dot_')
  # end
#   
  # def authorized? message
    # authorizer = authorize_for message
    # user_method = worm_case('russ.olsen') + '_authorized?'
    # if authorizer.respond_to? user_method
      # authorizer.send user_method, message
    # end
    # authorizer.authorized? message
  # end
# end
# 
# msgw = MessageGateway.new
# puts msgw.process_message "http://russolsen.com/some/place"
# msgw.process_message "http://fred@russollsen.com"
# msgw.process_message "smtp://fred@russollsen.com"
# msgw.process_message "file://fred@russollsen.com"

=begin
message is sent by http.
message is sent by smtp.
message is sent by file. 
=end
class Motherboard
end

class Computer
  attr_accessor :motherboard
  
  def initialize(motherborad= Motherboard.new)
    @motherboard = motherboard
  end
end
class ComputerBuilder
  attr_reader :computer
  def initialize
    @computer = Computer.new
  end
  
  def method_missing name, *args
    words = name.to_s.split("_")
    return super(name, *args) unless words.shift == 'add'
    
    words.each do |word|
      next if word == 'and'
      send "add_#{word}"
    end
  end
  
  private
  def add_cd
    puts "add_cd"
  end
  def add_dvd
    puts "add_dvd"
  end
  
  def add_cpu
    puts "add cpu"
  end
  
  
    
  
end

#don't use multiple methods call, just use this format: add_cd_and_dvd_and_cpu:
builder = ComputerBuilder.new
builder.add_cd_and_dvd_and_cpu
=begin
add_cd
add_dvd
add cpu 
=end

# require 'mailfactory'

# require 'madeleine'
# 
# class Employee
  # attr_accessor :name, :number, :address
#   
  # def initialize name, number, address
    # @name, @number, @address = name, number, address
  # end
#   
  # def to_s
    # "Employee: name: #{name} num: #{number} addr: #{address}"
  # end
# end
# 
# class EmployeeManager
  # def initialize
    # @employees = {}
  # end
#   
  # def add_employee e
    # @employees[e.number] = e
  # end
#   
  # def change_address number, address
    # employee = @employees[number]
    # raise 'No such employee' unless employee.nil?
    # employee.address = address
  # end
#   
  # def delete_employee number
    # @employees.remove number
  # end
#   
  # def find_employee number
    # @employees[number]
  # end
# end

a = ['joe', 'sam', 'george']
p a.all?{|elem| elem.length < 4 } #false

p a.any?{|elem| elem.length < 4 } #true

class Account
  attr_accessor :name, :balance
  
  def initialize(args={})
    @name, @balance = args[:name], args[:balance]
  end
  
  def <=> other
    @balance <=> other.balance
  end
#   
  def + other
    Account.new(name: @name, balance: @balance + other.balance)
  end
end

# class Portfolio
  # include Enumerable
#   
  # def initialize
    # @accounts = []
  # end
#   
  # #override each method:
  # def each(&block)
    # @accounts.each(&block)
  # end
#   
  # def <<(account)
    # @accounts << account
  # end
# end

#or use forwardable as method 2
require 'forwardable'
class Portfolio
  extend Forwardable
  
  include Enumerable
  
  def initialize
    @accounts = []
  end
  
  def_delegators :@accounts, :each, :<<, :any?, :map, :reduce
  
end

acc1 = Account.new(name: "matt", balance: 3000)
acc2 = Account.new(name: "min", balance: 2000)
acc3 = Account.new(name: "max", balance: 4000)
# 
my_portfolio = Portfolio.new
my_portfolio << acc1
my_portfolio << acc2
my_portfolio << acc3
# 
p my_portfolio.any?{|a| a.balance > 2000} #true
p my_portfolio.map{|a| a.balance > 2000} #[true, false, true]
p my_portfolio.reduce(&:+) ##<Account:0x007fdef485ce30 @name="matt", @balance=9000>

p my_portfolio.max.name #"max"




s = 'Peter Piper picked a peck of pickled peppers'
p s.scan(/[pP]\w*/)#{|word| puts "The word is #{word}"} #["Peter", "Piper", "picked", "peck", "pickled", "peppers"]
=begin
The word is Peter
The word is Piper
The word is picked
The word is peck
The word is pickled
The word is peppers 
=end

h = {:name=>:russ, :eys=>:blue, :sex=>:male}
h.each_key{|key| puts key}
h.each_value{|value| puts value}

p h.keys #[:name, :eys, :sex]
p h.values #[:russ, :blue, :male]
p h.values_at(:name, :sex) #[:russ, :male]

class Observer
  def update
    puts "news updated. "
  end
end
module Subject
  
  def observers
    @observers ||= []
  end
  
  #save the block until notify
  def add_observer &observer
    observers << observer
  end
  
  def pop observer
    observers.delete observer
  end
  
  def notify_observers
     observers.each do |ob|
       ob.call self
       # p self ##<Employee:0x007fc023853cd0 @name="Fred", @address="Crane Operator", @salary=3500, @observers=[#<Proc:0x007fc023853aa0@meta.rb:1167>]>
     end
  end
 
  
end

class Employee
  include Subject
  
  attr_reader :name, :address, :salary
  
  def initialize name, title, salary
    @name, @address, @salary = name, title, salary
  end
  
  def salary= new_salary
    @salary = new_salary
    notify_observers
  end
  
  
end

fred = Employee.new 'Fred', 'Crane Operator', 3000

# fred.add_observer Observer.new
# fred.add_observer Observer.new

fred.add_observer do |changed_employee|
  puts %Q{Cut a new check for #{changed_employee.name}}
  puts %Q{His salary is now #{changed_employee.salary}}
end
# fred.add_observer Observer.new

fred.salary = 3500 #news updated
=begin
 Cut a new check for Fred
  

    His salary is now 3500 
=end

module AnotherPerson
  def self.prepended base
    puts "#{self} prepended to #{base}"
    # raise "there's something wrong."
  end
  
  def name
    puts 'My name belongs to Person'
  end
end

class User
  # include AnotherPerson
  prepend AnotherPerson
  def name
    puts "My name belongs to User"
  end
end

User.new.name #My name belongs to User if use include, if use prepend: My name belongs to Person

=begin
AnotherPerson prepended to User
My name belongs to Person 
=end

class Person
  def method_missing name, *args
    puts "#{name} not defined on #{self}"
  end
  
  def name
    puts "my name is Person"
  end
end

p = Person.new
p.name
p.address
=begin
 my name is Person
address not defined on #<Person:0x007fa573184410> 
=end

class Report
  attr_reader :title, :text
  
  def initialize &formatter
    @title = 'Monthly Report'
    @text = 'This is ok.'
    @formatter = formatter
  end
  
  def output_report
    @formatter.call(self) #same as yield self
  end
end

html_report = Report.new do |r|
  puts %Q{Today's html report include #{r.title} and #{r.text}}
end
html_report.output_report #Today's html report include Monthly Report and This is ok.

plain_report = Report.new do |r|
  puts %Q{Today's text report include #{r.title} and #{r.text}}
end
plain_report.output_report #Today's text report include Monthly Report and This is ok.


v1 = 1


class MyClass
  v2 = 2
  # local_variables
  puts local_variables
  puts self.inspect #MyClass
  # puts v1

  def my_method #only variable available for instance(self), so v1 and v2 is invisible for instance
    # puts v1
    # puts v2
    v3 = 3
    v3
  end
end

puts MyClass.new.my_method










