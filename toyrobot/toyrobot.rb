#!/usr/bin/env ruby

require_relative 'simulator'

if ARGV.length > 0
  puts File.read(File.dirname(__FILE__) + '/../README.md')
  exit
end

puts "Please type the instructions here:"

begin
  simulator = Simulator.new
  while command = $stdin.gets  #execute them one at a time until EOF is reached and space is allowed
    simulator.dispatch command
  end
rescue =>e
  puts e.message
end
