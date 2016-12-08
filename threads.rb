=begin
require 'net/http'

pages = %w(www.rubycentral.com slashdot.org www.google.com)
threads = []
for page in pages # page is shared by all of threads
	threads << Thread.new(page) do |url|
		h = Net::HTTP.new(url, 80)
		puts "Fetching: #{url}"
		resp = h.get('/', nil)
		puts "Code = #{resp.code}"
		puts "Got #{url}: #{resp.message}"
	end # variables in this block are not shared
end
threads.each{|thr| thr.join }


Thread.abort_on_exception = true
threads = []
4.times do |number|
	threads << Thread.new(number) do |i|
		raise "boom!" if i == 2
		print "#{i}\n"
	end

end
threads.each{|thr| thr.join}

threads.each do |thr|
	begin
		thr.join
	rescue RuntimeError => e
		puts "Failed: #{e.message}"
	end
end


class Chaser
	attr_reader :count
	def initialize(name)
		@name = name
		@count = 0
	end

	def chase(other)
		while @count < 5
			while @count - other.count > 1
				Thread.pass
			end
			@count += 1
			print "#@name: #{count}\n"
		end
	end
end

c1 = Chaser.new("A")
c2 = Chaser.new("B")

threads = [ Thread.new {Thread.stop; c1.chase(c2)}, Thread.new {Thread.stop; c2.chase(c1)}]

index = rand(2)
threads[index].run 
threads[1-index].run 

threads.each{|thr| thr.join}


require 'monitor'
class Counter < Monitor
	include MonitorMixin

	attr_reader :count
	def initilize
		@count = 0
		#super
	end
	 def tick
	 	synchronize do
	 		@count += 1
	 		puts "#@count"
	 	end
	 end
end

	c = Counter.new
	t1 = Thread.new { 4.times { c.tick } }
	t2 = Thread.new { 4.times { c.tick } }

	t1.join; t2.join
=end

	fork do
		puts "in Child, pid = #$$"
		exit 99
	end
	pid = Process.wait
	puts "Child terminated pid = #{pid}, status = #{$?.exitstatus}"