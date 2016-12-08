class File
	def File.my_open(*args)
		result = file = File.new(*args)
		if block_given?
			result = yield file
			file.close

		end
		return result
	end
end

	File.my_open("test", "r") do |file| #same as File.open()
		while line = file.gets
			puts line
		end
	end

#same as below: 

	File.open("test", "r") do |file|
		while line = file.gets
			puts line
		end

	end