  
#define some constants: 
TableSize = [5,5]
   
Step = 1
  
#4 directions used now
Directions = ["NORTH", "EAST", "SOUTH", "WEST"]
  
#the moving strategy in each direction
MovingStrategy = { "NORTH": [0,1], "EAST": [1,0], "SOUTH": [0, -1], "WEST": [-1,0] }

#repopen the Array to define some operators for 2 Arrays:  
class Array
  
    #define the less-than operator
    def <=(other)
      (0..other.first).include?(first) && (0..other.last).include?(last)
    end
    
    #define the add operator
    def +(other)
      zip(other).map { |x, y| x + y }
    end
    
    #multiplication operator
    def *(other)
      zip(other).map { |x, y| x * y }
    end
end

class Robot
  
  #place will put the toy robot on the table in position X,Y and facing one specific direction 
  def place *args    
    args[0..1] <= TableSize && Directions.include?(args.last) && @position_info = args
  end

  #Rotates the robot 90 degrees to the left (i.e. counter-clockwise) without changing the position of the robot.
  def left   
    #only if robot is available to change
    @position_info[-1] = Directions[Directions.index(@position_info.last) - 1] 
  end 

  #Rotates the robot 90 degrees to the right (i.e. clockwise) without changing the position of the robot.
  def right
    @position_info[-1] = Directions[(Directions.index(@position_info.last) + 1) % Directions.size]  
  end
  
  #Moves the toy robot one unit forward in the direction it is currently facing.
  def move
    #get the steps to take
    steps = MovingStrategy[@position_info.last.to_sym] * [Step, Step]
    
    #take the steps if robot is not going to fall down the table
    (new_position = @position_info[0..1] + steps) <= TableSize && @position_info[0..1] = new_position 
  end 
 
  #Announces the X,Y and F of the robot.
  def report
    puts "The current location of Robot is #{@position_info.join(",")}"
  end  
end

#This is a proxy class to read, parse the cmd lines from stdin and then dynamically disaptch the cmds to methods defined in Robot
class Commands
  
  def initialize
    rbt = Robot.new
    
    placed = false
    while arg = gets()
      if arg =~ /\A(PLACE)(\s*\d\s*),(\s*\d\s*),(\s*\w+)\Z/i   
        placed = rbt.send $1.downcase, $2.to_i, $3.to_i, $4.to_s.upcase 
        puts "Please place the robot on the table, following instructions will be ignored." unless placed
      elsif arg =~ /\A(MOVE|LEFT|RIGHT|REPORT)\Z/i
        rbt.send $1.downcase if placed      
      else
        $stderr.puts "Invalid input for #{arg}"
      end
    end
  end
end

begin
  cmd = Commands.new
rescue =>e
  puts e.message
end
