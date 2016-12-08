class Song
attr_reader :name, :artist
   def initialize(name, artist, duration)
	 @name = name
	 @artist = artist
	 @duration = duration
	end

def to_s
	"Song: #@name #@artist #@duration"
end
end

class KaraokeSong < Song
	@@plays = 0
	attr_reader :name, :artist, :duration, :lyrics
	attr_writer :name, :artist, :duration, :lyrics
	def initialize(name, artist, duration, lyrics)
		super(name, artist, duration)
		@lyrics = lyrics
		@play = 0
	end

def play
	@play += 1
	@@plays += 1
	puts "This song plays #@play times and Total #@@plays."
end

	def to_s
		super + " #@lyrics"
	end

end

class MyLogger
	private_class_method :new
	@@logger = nil
	def MyLogger.create
		@@logger = new unless @@logger
		@@logger
	end
end

=begin
puts MyLogger.create.object_id
puts MyLogger.create.object_id

song = KaraokeSong.new("Bicyclops", "Fleck", 260, "And now....")
puts song.inspect
puts song.to_s
puts song.name
puts song.artist
puts song.duration
puts song.lyrics

song.name = "judy"
song.artist = "wu"
puts song.name
puts song.artist
song.play
song.play
=end
