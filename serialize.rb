class A
  attr_reader :my_variable
  def initialize variable
    @my_variable = variable
  end
end
a = A.new(1)
b = Marshal.dump(a)
c = Marshal.load(b)
puts c.my_variable

######################################################################
=begin
 serializing:  
 easily convert the important data from an object into a string and write that out to a file. (the serialized object is human-readable)
 Then when you need to, you just read the file, parse the string and recreate the object 
=end
require 'yaml'

class SerialiazeClass
  def initialize name, number
    @name = name
    @number = number
  end
  
  # def to_s
    # "In A:\n #{@string}, #{@number}\n"
  # end
end

# class B
  # def initialize number, a_object
    # @number = number
    # @a_object = a_object
  # end
#   
  # def to_s
    # "In B:\n #{@number}, #{@a_object}\n"
  # end
# end
# 
# class C
  # def initialize b_object, a_object
    # @b_object = b_object
    # @a_object = a_object
  # end
#   
  # def to_s
    # "In C:\n #{@a_object}, #{@b_object}\n"
  # end
# end

a = SerialiazeClass.new("hello world", 5)
# b = B.new(7, a)
# c = C.new(b, a)

# puts c

# #serialize the objects:
# test_data = [a, ]
serialized_object =  YAML.dump(a)
p serialized_object ##<SerialiazeClass:0x007fb78a9a7d58>

puts "Marshal begin"
############################################Marshal###########################
#to binary
#Marshal: The disadvantage of Marshal is the fact the its output it not human-readable. The advantage is its speed.
serialized_object = Marshal::dump(a)
puts Marshal::load(serialized_object) #use print instead put to avoid extra line when output objects to a file
=begin
 In A:
 hello world, 5 (to_s)
 #<A:0x007ffe02a3a5e0> without to_s
=end
############################################Marshal###########################
puts "Marshal end"
############################################YAML###########################
# test_data = [a, b, c]
# class1 = MyClass.new
# class2 = MyClass.new
# test_data = [class1, class2]
# #serialize the objects:
# serialized_object =  YAML::dump(test_data)#"---\n- !ruby/object:MyClass\n  var1: 5\n- !ruby/object:MyClass\n  var1: 5\n"
# serialized_object = YAML::dump(test_data)
# p serialized_object
# File.open("judy.yaml", "w") do |file|
  # (1..10).each do |index|
    # file.puts YAML::dump(A.new("hello world", index))
    # file.puts ""
  # end
# end

#read from file: 
# array = []
# $/="\n\n"
# File.open("judy.yaml", "r").each do |object|
  # array << YAML::load(object)
# end
# p array.inspect
# loaded_obj = YAML::load(serialized_object)
# p loaded_obj
############################################YAML###########################

######################################################################

#########################user benchmark##############
require 'benchmark'

def benchmark_serialize(output_file)
  Benchmark.realtime do
    File.open(output_file, 'w') do |file|
      (1..500_000).each do |index|
        yield(file, SerialiazeClass.new("hello world", index))
      end
    end
  end
end

# puts "YAML:"
# time = benchmark_serialize("dlog/yaml.dat") do |file, object|
#   
  # file.puts YAML::dump(object)
  # file.puts ""
# end
# 
# puts "Time: #{time} sec"
# require 'json'
# 
# puts "JSON:"
# time = benchmark_serialize("dlog/json.dat") do |file, object|
  # file.puts object.to_json
  # # file.puts ""
# end
# puts "Time: #{time} sec"

puts "Marshal: "
time = benchmark_serialize("dlog/marshal.dat") do |file, object|
  file.puts Marshal::dump(object) #don't use puts when outputting Marshalled objects to a file (use print instead), this way you avoid the extraneous newline from the puts
  file.puts "---_---"
end
# 
puts "Time: #{time} sec"
=begin
YAML:
Time: 70.71975948399631 sec
JSON:
Time: 4.989724585000658 sec
Marshal: 
Time: 3.217343525000615 sec

result: 
--- !ruby/object:SerialiazeClass
name: hello world
number: 1

--- !ruby/object:SerialiazeClass
name: hello world
number: 2

--- !ruby/object:SerialiazeClass
name: hello world
number: 3


"#<SerialiazeClass:0x007f8f5c8c9928>"
"#<SerialiazeClass:0x007f8f5c8c96d0>"
"#<SerialiazeClass:0x007f8f5c8c9428>"
"#<SerialiazeClass:0x007f8f5c8c90b8>"
"#<SerialiazeClass:0x007f8f5c8c8e88>"

o:SerialiazeClass:
@nameI"hello world:ET:@numberi
---_---
o:SerialiazeClass:
@nameI"hello world:ET:@numberi
---_---
o:SerialiazeClass:
@nameI"hello world:ET:@numberi
---_---

=end