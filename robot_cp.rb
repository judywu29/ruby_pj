

module Filter
  def before_filter name
    @@filter = name
  end
  
  def method_added name
    return if @filtering
    return if @@filter == name
    return if name == :initialize
    
    @filtering = true
    alias_method :"original_#{name}", name
    define_method name do |*args|
      self.send @@filter
      self.send :"original_#{name}", *args
    end
    @filtering = false
  end
end
require 'active_support/all'
class TestCaseOne
    include ActiveSupport
    
    def save
      puts "--save"
    end
    
    def save_with_validation
      puts "doing validation"
      puts "--save"
    end
    
    alias_method_chain :save, :validation
    
end

TestCaseOne.new.save

class Test
  extend Filter
  before_filter :logging
  
  def foo
    puts "call #{__method__}"
  end
  
  def logging
    puts "logging..."
  end
end

Test.new.foo 
=begin
 #logging
 #call foo 
=end


# require 'active_support/all'
# class Record
  # include ActiveSupport::Callbacks
  # define_callbacks :save
#   
  # def save
    # run_callbacks :save do
      # puts "--save"
    # end
  # end
#   
#   
# end
# 
# class PersonRecord < Record
  # set_callback :save, :before, :saving_message
#   
  # def saving_message
    # puts "start saving message..."
  # end
#   
  # set_callbacks :save, :after do |object|
    # puts "message saved. "
  # end
# end
# person = PersonRecord.new
# person.save









        