require './robot'

#This is a proxy class to parse the cmd lines and then dynamically disaptch the cmds to methods defined in Robot
class Simulator
  
  attr_reader :rbt  
  def initialize
    @rbt = Robot.new
  end
  
  def dispatch command    
    @placed ||= false     #if the robot is placed on the table
    if command =~ /\A(PLACE)\s+(\d+)\s*,\s*(\d+)\s*,\s*(\w+)\s*\Z/i
      @placed = @rbt.send $1.downcase, $2.to_i, $3.to_i, $4.to_s.upcase
        
      puts "Please place robot on the table." unless @placed
    elsif command =~ /\A(MOVE|LEFT|RIGHT|REPORT)\s*\Z/i
      @placed ? @rbt.send($1.downcase) : puts("Ignoring #{$1} until robot is PLACED.")
    else
      puts "Invalid input: #{command}"
    end
  end
end