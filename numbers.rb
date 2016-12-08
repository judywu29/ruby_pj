=begin
 Fixnum: small numbers, Bignum: big ones
 Numeric, Integer, Bignum, Complex...
 to_i, to_f: can have a argument like 2, 8, 16 decimal numbers, same as to_s from integer to string
 from string to numbers: oct, to_i, hex,  
 
 Integer(''), Float(''), raise error when a string cann't be completely parsed as a number
=end
puts "13:a".to_i
puts "60.5 Misc".to_f
puts '405'.oct #261
puts '405'.to_i(8) #261

# puts Integer('1001 night') #invalid value for Integer(): "1001 night"

class NumberParse
  @@number_regexps = {
    :to_i => /([+-]?[0-9]+)/,
    :to_f => /([+-]?([0-9]*\.)?[0-9]+(e[+-]?[0-9]+)?)/i,
    :oct => /([+-]?[0-7]+)/,
    :hex =>/([+-]?(0x)?[0-9a-f]+)\b/i
  }
  
  def self.re parsing_method=:to_i
    reg = @@number_regexps[parsing_method]
    raise ArgumentError, "No regexp for #{parsing_method.inspect}!" unless reg
    return reg
  end
  
  def extract s, parsing_method=:to_i
    numbers = []
    s.scan(NumberParse.re parsing_method) do |match| #use the name of the class, not self(object)
      numbers << match[0].send(parsing_method) #numbers object
    end
    numbers
  end
end

p = NumberParse.new
pw = "Today's numbers are 104 and 391"
# NumberParse.re(:to_i).match(pw).captures
puts p.extract(pw, :to_i) # 104, 391

=begin
 float difference: approx, no method
=end
# puts 98.6.approx 98.66
# puts 98.6.approx 98.66, 0.001

=begin
 high precision number: 
 require 'bigdecimal' 
 float: Float::MIN_EXP(-1021) ~ Float::MAX_EXP(1024)
=end
require 'bigdecimal'
puts BigDecimal("10").to_s #0.1E2

a = ["item1", "item2", "item3"]
puts a[rand a.size] #item2

srand 1 #start the seed from number 1
puts rand(1000) #37

def mean array
  array.inject(0){|result, x| result += x}/array.size.to_f
end

puts mean [1,2,3,4] #2.5

def median array, already_sorted=false
  return nil if array.empty?
  array.sort! unless already_sorted
  pos = array.size/2
  array.size%2 == 1 ? array[pos] : mean(array[pos-1..pos])
end

puts median [1,2,3,4,5] #3
puts median [3,2,4,6] #3.5

def modes array, find_all=true
  histogram = array.inject(Hash.new(0)){|h, n| h[n] += 1; h} #{1=>2, 2=>2, 3=>1, 4=>1}
  # puts histogram
  modes = nil
  histogram.each_pair do |item, times|
    modes<<item if modes && times == modes[0] and find_all
    modes = [times, item] if (!modes && times>1) or (modes && times>modes[0])
  end
  return modes ? modes[1..modes.size] : modes
end

puts modes [1,1,2,2,3,4]

numbers = ["5", "4", "3", "3", "7"]
#upto is a method: 
0.upto numbers.length-1 do |i|
  puts numbers[i].to_i #5 4 3 3 7
end

require 'rubygems'
require 'creditcard'

puts '5276 4400 6542 1319'.creditcard? #true

=begin
 fibonacci
  
=end
def fibonacci limit=nil
  seed1 = 0
  seed2 = 1
  while !limit or seed2 <= limit
    yield seed2
    seed1, seed2 = seed2, seed1+seed2
  end
end

fibonacci(3) {|x| puts x} #1 1 2 3
fibonacci{|x| break if x > 20; puts x}
=begin
 1
1
2
3
5
8
13 
=end

def oscillator
  x = 1
  while true
    yield x
    x *= -2
  end
end

oscillator{|x| break if x.abs > 50; puts x}
=begin
  1
-2
4
-8
16
-32
=end
#To BigDecimal: to_d, To Rational: to_r, To float: to_f From Float to Rational : xx.to_d.to_r













