class MyOpenStruct
  def initialize
    @attributes = {}
  end

  def method_missing(name, *args)
    attribute = name.to_s
    # puts attribute (flavor=, so use chop to remove the last character)
    attribute =~ /=$/ ? @attributes[attribute.chop] = args[0] : @attributes[attribute]
  end
end

struct = MyOpenStruct.new
struct.flavor = "vanilla"

puts struct.flavor