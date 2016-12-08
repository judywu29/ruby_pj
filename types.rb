#
# require '/users/mac/desktop/ruby/songlist.rb'
# require '/users/mac/desktop/ruby/mysong.rb'
# require 'FileUtils'

=begin
num = 81
6.times do
puts "#{num.class}: #{num}"
num *= num
end

3.times{puts "X"}
1.upto(5){|i| puts i}
6.downto(2){|i| puts i}
# 50.step(80, 5){|i| puts i}
=end
# 50.step(80, 5){|i| puts i}
=begin
File.open("test", "r") do |file|
	songs = SongList.new
	file.each do |line|
		filename, length, name, title = line.chomp.split(/\s*\|\s*/)
		name.squeeze!(" ")
		mins, secs = length.scan(/\d+/)
		songs.append(Song.new(title, name, mins.to_i*60 + secs.to_i))
	end

	puts songs[0]
	puts songs.lookup("fats")
	puts songs.lookup("louis")
	puts songs.lookup("judy")

end


digits = 0..9
puts digits.include?(5)
puts digits.min
puts digits.max 
puts digits.reject{|i| i<5}
#digits.each {|digit| dial(digit)}


def take_block(p1)
	if block_given?
		puts yield(p1)

	else puts p1
				puts p1	end

end
take_block("no block")
take_block("no block"){|s| s.sub(/no /, '')}

class TaxCalculator
	def initialize(name, &block)
		@name = name
		@block = block
	end
	def get_tax(amount)
		puts "#@name on #{amount} = #{@block.call(amount)}"
	end
end

tc = TaxCalculator.new("Sales tax"){|amount| amount*0.75}
tc.get_tax(100)
tc.get_tax(200)

print "(t)imes or (p)lus: "
times = gets
print "number: "
number = Integer(gets)
if times =~ /^t/
	calc = lambda{|n| n*number}
else calc = lambda{|n| n+number}
end
puts((1..10).collect(&calc).join(", "))

duration = 200
unless duration > 180
	puts "true"
else puts "false"
end

=end

# 3.times do
# 	print "Ho!"
# end
# 0.upto(9) do |x|
# 	print x
# end
#
# 0.step(12,3) do |x|
# 	print x
# end
#
# [1,2,3,5].each{|x| print x}


3.times{|i| puts i}
#puts a
