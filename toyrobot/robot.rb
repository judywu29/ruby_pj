  
#define some constants: 
TableSize = [5, 5] #table is set to a square of dimensions 5 units x 5 units by default 
   
Step = 1 #step to take for each move
  
#4 directions used now
Directions = ["NORTH", "EAST", "SOUTH", "WEST"]
  
#the moving strategy in each direction in 2 dimentions
MovingStrategy = { "NORTH": [0, 1], "EAST": [1, 0], "SOUTH": [0, -1], "WEST": [-1, 0] }

class Robot
  
  attr_accessor :position_info #position_info is an array including x,y position and direction eg.[0,1,"east"]
  
  #place will put the toy robot on the table in position X,Y and facing one specific direction 
  def place *position_info    
    inside?(position_info[0..1], TableSize) && Directions.include?(position_info.last) && @position_info = position_info
  end

  #Rotates the robot 90 degrees to the left (i.e. counter-clockwise) without changing the position of the robot.
  def left   
    @position_info[-1] = Directions[Directions.index(@position_info.last) - 1] 
  end 

  #Rotates the robot 90 degrees to the right (i.e. clockwise) without changing the position of the robot.
  def right
    @position_info[-1] = Directions[(Directions.index(@position_info.last) + 1) % Directions.size]  
  end
  
  #Moves the toy robot one unit forward in the direction it is currently facing.
  def move
    #get the steps to take according to its direction, Step for x, y is set to 1 as default
    steps = MovingStrategy[@position_info.last.to_sym].zip([Step, Step]).map { |x, y| x * y }
    
    #get the new position by adding the steps on current position
    new_position = @position_info[0..1].zip(steps).map { |x, y| x + y }
    #take the steps if robot is not going to fall down off the table
    inside?(new_position, TableSize) && @position_info[0..1] = new_position 
  end 
 
  #Announces the X,Y and F of the robot.
  def report
    puts "The current location is #{@position_info.join(",")}"
  end
  
  private
  #if the position is inside the table
  def inside?(position, table)
    (0..table.first).include?(position.first) && (0..table.last).include?(position.last)
  end
  
end
