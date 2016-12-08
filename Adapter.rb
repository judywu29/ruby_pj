class Encrypter
  def initialize(key)
    @key = key
  end
  
  def encrypt(reader, writer)
    key_index = 0
    while not reader.eof?
      clear_char = reader.getc
      encrypted_char = clear_char #@key[key_index]
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end

reader = File.open('message.txt')
writer = File.open('message_encrypted.txt', 'w')
encrypter = Encrypter.new('my secret key')

encrypter.encrypt(reader, writer)

=begin
  
situation: need to satisfy some interfaces or methods on new objects. and the modification is simple and clear.
 it means: i have to use reader/write objects: if there's a different object who doesn't have those methos as reader:
 in ruby way: open the class to add:  
 class String
   def xxx
   end
 end
 add singleton methods: 
or obj = String.new
class << obj
end

or String.class_eval do
  define_method :xxx
end

or def obj.xxx 
end

or use alias or alias chain
Monkey patch: 用统一接口增加方法
=end

require 'soap/wsdlDriver'
wsdl_url = 'http://www.webservicex.net/weatherforecast.asmx?wsdl'
proxy = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver
weather_info = proxy.GetWeatherByZipCode('ZipCode'=>'3004')
puts weather_info






