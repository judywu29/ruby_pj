#shared the scope between all of the methods
lambda{
  
   
  TABLE_X = 5
  TABLE_Y = 5
  
  STEP = 1
  
  #4 directions used now
  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]
  NORTH, EAST, SOUTH, WEST = DIRECTIONS
  
  RIGHT, LEFT, MOVE, PLACE = ["right", "left", "move", "place"]
  
  
  is_robot_availabe = false
  pos_x = 0
  pos_y = 0
  direction = nil
  
  define_method :place do |*args|
    is_robot_availabe = true    
    pos_x,pos_y,direction  = args
    direction = direction.to_s
    # p direction
    direction.chomp!#.strip!.upcase!
    if not (0..TABLE_X).include?(pos_x) or not (0..TABLE_Y).include?(pos_y)
       puts "Warning: The position of Robot at (#{pos_x}, #{pos_y}) is outside the table (5,5)."
       is_robot_availabe = false
       return
    end

    if not DIRECTIONS.include?(direction)
       puts "Warning: #{direction} is invaid. Robot can only move towards the four directions: \n"\
       "#{DIRECTIONS.inspect}."
       is_robot_availabe = false
       return
    end
  end
        #place will put the toy robot on the table in position X,Y and facing one specific direction
  define_method :left do
       return if !is_robot_availabe 
       direction = DIRECTIONS[DIRECTIONS.index(direction) - 1]  
  end 

 define_method :right do
        return if !is_robot_availabe
        direction = DIRECTIONS[(DIRECTIONS.index(direction) + 1) % 4]
  end
  
  define_method :move do
    return if !is_robot_availabe
    case direction
     when "NORTH"
       if pos_y + STEP <= TABLE_Y
                    pos_y += STEP
                    return
                end
                
            when "EAST"
                if pos_x + STEP <= TABLE_X
                    pos_x += STEP
                    return
                end
                
            when "SOUTH"
                if pos_y - STEP >= 0
                    pos_y -= STEP
                    return
                end
                
            when "WEST"
                if pos_x - STEP >= 0
                    pos_x -= STEP
                    return
                end
                
            end
            puts "Warning: Robot cannot move towards #{direction} anymore. "
            # return "MOVE" #for test
  end 

  define_method :report do
    return if !is_robot_availabe
    puts "Report: The current location of Robot is #{pos_x}, #{pos_y} and facing towards #{direction}"
  end
  
  alias :PLACE :place
  alias :LEFT :left
  alias :RIGHT :right
  alias :MOVE :move
    
  define_method :east do
    "EAST"
  end
  
  
# end
  
}.call
 
 # Dir.glob('input.rb') do |file|
   # load file, true #will create a anonymous module for constants
 # end
 # if input.rb and File.exist? input.rb
   # load input.rb, true
 # end
 
 #use eval:
 eval(File.read('input.txt'))
 # File.readlines("input.txt").each do |line|
  # puts %Q{
    # #{line.chomp} ==> #{eval(line)}
  # }
# end
 
  # env = Object.new 
   # File.open("input.txt", "r") do |file|
     # while line = file.gets
       # case line
        # #format like: PLACE 1,2,EAST
       # when /\A\s*PLACE\s*(\d+)\s*\,\s*(\d+)\s*\,\s*(\w+)\s*/i
         # env.send "place", $1.to_i,$2.to_i,$3.upcase 
#   
       # when /\A\s*(LEFT|RIGHT|MOVE|REPORT)\s*$/i
         # env.send line.chomp.strip.downcase
      # end                  
     # end
   # end
#    
# 
# rescue => e
  # puts e.message
  # puts "Error: Reading Input file failed, please add the input file. "
# end                    