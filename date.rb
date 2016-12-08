now =  Time.now #2015-07-29 17:49:09 +1000
t = Time.at(0) #1970-01-01 10:00:00 +1000
puts t.sec, t.min, t.hour, t.day, t.month, t.year, t.wday, t.yday, t.isdst, t.zone
=begin
 0
0
10
1
1
1970
4: numeric day of week, 
1: day of the year
false is daylight saving time in effect?
AEST
Y: 4 digital, %H(24 clock):%M:%S %Z (zone) %I:12 clock %A: week %B: Month: January
=end
puts Time.local(1700, 4, 9)#1700-04-09 00:00:00 +1000
puts Time.gm(2111, 10, 5) #2111-10-05 00:00:00 UTC
puts now.gmtime #2015-07-29 07:56:40 UTC
puts now.usec #361695 microseconds

require 'date'
puts Date.parse('2/9/2007').to_s #2007-09-02
puts Date.parse 'Wednesday, January 10, 2001' #2001-01-10


american_date = '%m/%d/%y'
puts Date.strptime '2/9/07', american_date #2007-02-09

european_date = '%d/%m/%y'
puts Date.strptime '2/9/07', european_date #2007-09-02

date_and_time = '%m-%d-%Y %H:%M:%S %Z'
puts Date.strptime '02-09-2007 12:30:44 EST', date_and_time  #??

word_date = '%A, %B %d, %Y'
puts Date.strptime 'Wednesday, January 10, 2001', word_date #2001-01-10

require 'time'
mail_received = 'Tue, 1 Jul 2003 10:52:37 +0200'
puts Time.rfc822 mail_received #2003-07-01 10:52:37 +0200

last_modified = 'Tue, 05 Sep 2006 16:05:51 GMT'
puts Time.httpdate last_modified #2006-09-05 16:05:51 UTC

timestamp = '2001-04-17T19:23:17.201Z'
t = Time.iso8601 timestamp
puts t.sec, t.tv_usec #17, 201000

t = Time.new #2015-10-30 09:00:17 +1100
puts t
puts t.gmtime #2015-10-29 23:08:49 UTC

week_day = Time.new.wday
puts week_day
puts Time::RFC2822_DAY_NAME.index("Mon") #1, 

puts  Date._strptime('2001-02-03', '%Y-%m-%d')
#{:year=>2001, :mon=>2, :mday=>3}
puts  Date.strptime('2001-02-03', '%Y-%m-%d')
#2001-02-03


















