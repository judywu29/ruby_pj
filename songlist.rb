require '/users/mac/desktop/ruby/mysong.rb'
require 'test/unit'

class WordIndex
	def initialize
		@index = {}
	end
	def add_to_index(obj, *phrases)
		phrases.each do |phrase|
			phrase.scan(/\w[-\w']+/) do |word|
			word.downcase!
			@index[word] = [] if @index[word].nil?
			@index[word].push(obj)
		end
	end
end
def lookup(word)
	@index[word.downcase]
end
end

class SongList
def initialize
	@songs = Array.new
	@index = WordIndex.new
end

def append(song)
	@songs.push(song)
	@index.add_to_index(song, song.name, song.artist)
	self
end

def delete_first()
	@songs.shift
end

def delete_last()
	@songs.pop
end

def [](index)
	@songs[index]
end

def lookup(word)
	@index.lookup(word)
end

end	

class VU
	include Comparable
	attr :volume
	def initialize(volume)
		@volume = volume
	end

	def inspect
		#' *@volume
	end

	def <=>(other)
		self.volume <=> other.volume
	end
	def succ
		raise(IndexError, "volume too big") if @volume >= 9
	end
end
medium_voume = VU.new(4) .. VU.new(7)
medium_voume.to_a
puts medium_voume.include?(VU.new(3))


class TestMe < Test::Unit::TestCase
	def test_delete
		list = SongList.new
		song1 = Song.new("Bob", "A", 260)
		song2 = Song.new("Tim", "B", 300)
		song3 = Song.new("Jam", "C", 400)
		list.append(song1).append(song2).append(song3)

		assert_equal(song1, list[0])
		assert_equal(song2, list[1])
		assert_equal(song3, list[2])
	end
end
#test1 = TestMe.new
#test1.test_delete

