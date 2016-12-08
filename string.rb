# class String
  # def substitue(binding=TOPLEVEL_BINDING)
    # eval %{"#{self}"}, binding
  # end
# end
# 
# template = %q{#{food}}
# food = 'bacon'
# 
# puts template.substitue binding #chunky bacon
# food = '#{system("dir")}'
# puts template.substitue binding #chunky #{system("dir")}
# 


# s = ".sdrawkcab si gnirts siht"
# puts s.reverse! #this string is backwards.
# 
# s= "order. wrong the in are words These"
# puts s.split(/(\s+)/).reverse!.join('') #These words are in the wrong order.  # split them into a [] and then join them
# 
# puts "Three little  words".split(/\s+/) #["Three", "little", "words"]
# puts "Three little  words".split /(\s+)/  #["Three", " ", "little", "  ", "words"]

# 'foobar'.scan(/./) {|c| puts c} #f o o b a r, /./ match every character
# 'foobar'.each_byte{|x| puts "#{x} = #{x.chr}"}
# =begin
 # 102 = f
# 111 = o
# 111 = o
# 98 = b
# 97 = a
# 114 = r 
# =end
# 
# 
# french = "\xc3\xa7a va"
# french.scan(/./u){|c| puts c}
# =begin
 # ç
# a
#  
# v
# a 
# =end

#anything that's not whitespace is a word: /[^\s]+/
#accept dashes and apostrophes as parts of words: /[-'\w]+/
#$KCODE='u': UTF-8 support
class String
  def word_count
    frequences = Hash.new(0)
    scan(/(\w+([-'.]\w+)*)/){|word, ignore| frequences[word] += 1}
    return frequences
  end
end

puts %{"That F.B.I. fella--he's quite the man-about-town."}.word_count
#{"That"=>1, "F.B.I"=>1, "fella"=>1, "he's"=>1, "quite"=>1, "the"=>1, "man-about-town"=>1}

=begin
 cases: 
 upcase, downcase, swapcase, capitalize, upcase!, downcase!, swapcase!, capitalize!, tr(), tr!()
=end
a = 'LOWERCASE ALL VOWELS'
puts a.tr!('AEIOU', 'aeiou') #LoWeRCaSe aLL VoWeLS, also change a
puts a


=begin
 whitespace: space, tab(\t), newline(\n), linefeed(\r), form feed(\f): /\s/
 other spaces: \b or \010: \b,  \v or \012: \v
=end
puts "Line one\n\rLineTwo\n\r".gsub("\n\r", "\n")
puts "\n\rThis is a string\t and\f".gsub(/\s+/, " ") #" This is a string and "
puts "\bIt's whitespace, \vbut not\n".gsub(/[\s\b\v]+/, " ") # " It's whitespace, but not "
=begin
 center(6), lstrip, rstrip, strip, gsub!, strip!..ljust, rjust..
=end


=begin
 obj.is_a? tell u whether an object derives from the String class
 respond_to?: tell whether implements a certain method 
=end
puts 'A string'.respond_to? :to_str #true
puts 'A string'.is_a?(String) #true
puts Exception.new.respond_to? :to_str #false
puts 4.respond_to? :to_str #false
puts 4.is_a?(Integer) #true

=begin
 slice, [], /.**/ 
=end

s='My kingdom for a string'
puts s.slice 3,7 #kingdom, length: 7
puts s[3,7]
puts s[/.ing/] #king
puts s[/str.*/] #string
puts s.slice(3) #k
puts s.slice(-7, 3) #" st"
puts s[15...s.length]#"a string"

=begin
 handle non ASCII characters: Unicode characters encoded in UTF-8
 $KCODE='u'
 require 'jcode'
 
 or ruby -Ku -rjcode 
=end

=begin
 wrapping: word_wrap, word_wrap!no method
=end
lines = %Q{
  It may be difficult to wrap your mind around that if you're not familiar with the Ruby object model, but it's still easy to remember how these methods behave with a simple mnemonic device: when called on a class name constant, these two methods will allow you to create methods of the opposite type from their names
}
def wrap s, width=78
  s.gsub(/\s+/, " ").gsub(/(.{1,#{width}})( |\Z)/, "\\1\n")
end

puts wrap lines
=begin
 It may be difficult to wrap your mind around that if you're not familiar with
the Ruby object model, but it's still easy to remember how these methods
behave with a simple mnemonic device: when called on a class name constant,
these two methods will allow you to create methods of the opposite type from
their names 
=end
# puts lines.word_wrap

=begin
 succ: next one 
=end

=begin
 %r{} 

 =~: expression
 i: case insensitive
 m: multiple lines
 x: space out the expression with whitespace and comments 
=end

puts /a\nb/ =~ "banana\nbanana" #5
extended = %r{\ was #Match " was"
  \s+ #Match one whitespace character or more
  a #Match "a"
}xi
puts extended =~ "What was Alfred doing here?" #4
puts extended =~ "My, that was a yummy mango."#8
puts extended =~ "It was\n\na fool's errand" #2


=begin
 validaing an email address:
 1. probably_valid
 2.extract the hostname and do a DNS lookup to see if the hostname accepts email
 3.send email to the address, ask user to verify receipt. 
=end
def probably_valid? email
  valid = '[A-Za-z\d.+-]+'
  (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
end
puts probably_valid? 'joe@example.com' #true  
puts probably_valid? 'joe@examplecom' #false

require 'resolv'
def valid_email_host? email
  hostname = email[(email =~ /@/)+1..email.length]
  valid = true
  begin
    Resolv::DNS.new.getresource hostname, Resolv::DNS::Resource::IN::MX
  rescue Resolv::ResolvError
    valid = false
  end
  return valid
end

puts valid_email_host? 'joe@lcqkxjvoem.mil' #false
puts valid_email_host? 'joe@oreilly.com' #true

=begin
 spam or not spam, funny or not
  
=end

require 'rubygems'
require 'classifier'

classifier = Classifier::Bayes.new('Spam', 'Not spam')
classifier.train_spam 'are you in the market for viagra? we see viagra'
classifier.train_not_spam 'hi there, are we still on for lunch?'

puts classifier.classify "we sell the cheapest viagra on the market" #spam
puts classifier.classify "lunch sounds great" #not spam



# def my_method
  # yield
# end
# 
# v = 1
# my_method do
  # v += 1
# end
# 
# puts v
#%Q{}, %q{}, or %Q- String -
a_multiple_line_string = %Q-  The city is Melbourne.
  The temp is about 10 degree here. -
puts "#{a_multiple_line_string}"







