class Person
end

# Person.class_eval do
    # def say_hello
      # puts "hello!"
    # end
# end
# Person.say_hello #wrong, it's instance method
# Person.new.say_hello #OK, goes to Person

Person.instance_eval do
      def say_hello
      puts "hello!"
    end
end

Person.say_hello #OK, it's class method, goes to Person's eigenclass, Person is the object/instance
# Person.new.say_hello #wrong, 

# class Person
  # class << self  #goes to Person's eigenclass
    # def say_hello
      # puts "hello!"
    # end
  # end
# end

a = Person.new
a.instance_eval do
    def say_hello
      puts "hello!"
    end
end


  # class << a  #goes to a's eigenclass
    # def say_hello
      # puts "hello!"
    # end
  # end


#什么是单件方法，单件方法是在单件类中定义的方法（in eigenclass）
b = Person.new
# a.say_hello #OK
# b.say_hello #Wrong, it's only for a

=begin
 class_eval is a method of the Module class, meaning that the receiver will be a module or a class. 
 The block you pass to class_eval is evaluated in the context of that class. 
 Defining a method with the standard def keyword within a class defines an instance method, and that's exactly what happens here.

instance_eval, on the other hand, is a method of the Object class, meaning that the receiver will be an object. 
The block you pass to instance_eval is evaluated in the context of that object. 
That means that Person.instance_eval is evaluated in the context of the Person object. 
Remember that a class name is simply a constant which points to an instance of the class Class. 
Because of this fact, defining a method in the context of Class instance referenced by Person creates a class method for Person class. 
=end

