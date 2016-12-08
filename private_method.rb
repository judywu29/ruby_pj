class Test
  def self.public_method
    self.private_method

  end

  def public_instance_method
    # Test.public_method  #self.public_method: self: it's test instance, not Test
    # self.private_method
    private_instance_method # cannot be self.private_instance_method
    @v = 1
  end

  private
  def private_instance_method
    puts "hello private instance method"
  end

  def self.private_method
    puts "hello"
  end
end

Test.public_method
test= Test.new
test.public_instance_method

puts test.instance_variables #[@v]