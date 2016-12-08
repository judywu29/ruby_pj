
=begin
Implement a Robot who has 3 attributes: 
pos_x: position in X axis
pos_y: position in Y axis
direction: facing direction of the robot
can be accessed by the Commands object
=end
class Robot
  
  TABLE_X = 5
  TABLE_Y = 5
  
  STEP = 1
  
  #4 directions used now
  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]

  
  def initialize
        @is_robot_availabe = false
  end
    
    private
       
        #place will put the toy robot on the table in position X,Y and facing one specific direction
        def place args
          
            @is_robot_availabe = true
            
            @pos_x,@pos_y,@direction  = args

            if not (0..TABLE_X).include?(@pos_x) or not (0..TABLE_Y).include?(@pos_y)
                puts "Warning: The position of Robot at (#{@pos_x}, #{@pos_y}) is outside the table (5,5)."
                @is_robot_availabe = false
                return
            end

            if not DIRECTIONS.include?(@direction)
                puts "Warning: #{@direction} is invaid. Robot can only move towards the four directions: \n"\
                "#{DIRECTIONS.inspect}."
                @is_robot_availabe = false
                return
            end

             # return "PLACE" #for test
        end

        #left will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
        #i.e. from "NORTH" to "WEST", or from "SOUTH" to "EAST"
        def left(args) 
          return if !@is_robot_availabe
            #find its left elem
            @direction = DIRECTIONS[DIRECTIONS.index(@direction) - 1]
            # return "LEFT" #for test
        end

        #right will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
        #i.e. from "NORTH" to "EAST", or from "WEST" to "NORTH"
        def right(args)
          return if !@is_robot_availabe
            #find its right elem
            @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
            # return "RIGHT" #for test

        end 

        #MOVE will move the toy robot one unit forward in the direction it is currently facing.
        def move(args)
          return if !@is_robot_availabe
            case @direction
            when "NORTH"
                if @pos_y + STEP <= TABLE_Y
                    @pos_y += STEP
                    return
                end
                
            when "EAST"
                if @pos_x + STEP <= TABLE_X
                    @pos_x += STEP
                    return
                end
                
            when "SOUTH"
                if @pos_y - STEP >= 0
                    @pos_y -= STEP
                    return
                end
                
            when "WEST"
                if @pos_x - STEP >= 0
                    @pos_x -= STEP
                    return
                end
                
            end
            puts "Warning: Robot cannot move towards #{@direction} anymore. "
            # return "MOVE" #for test
        end

        #report will print the X,Y and F of the robot on the screen.
        def report(args)
          return if !@is_robot_availabe
            puts "Report: The current location of Robot is #{@pos_x}, #{@pos_y} and facing towards #{@direction}"
            # return "REPORT" #for test
        end
end 


begin
  cmdlist = Array.new{Array.new}
   File.open("input.txt", "r") do |file|
     while line = file.gets
       case line
        #format like: PLACE 1,2,EAST
       when /\A\s*PLACE\s*(\d+)\s*\,\s*(\d+)\s*\,\s*(\w+)\s*/i
         cmdlist << ["place",$1.to_i,$2.to_i,$3.upcase]
  
       when /\A\s*(LEFT|RIGHT|MOVE|REPORT)\s*$/i
         cmdlist << [line.chomp.strip.downcase]
      end                  
     end
   end
   

rescue => e
  puts e.message
  puts "Error: Reading Input file failed, please add the input file. "
else
   return if cmdlist.empty? || !cmdlist.assoc("place")
   # puts cmdlist
   rbt = Robot.new 
   cmdlist.each do |cmd| 
    rbt.send cmd[0], cmd.slice(1..3)
   end
end                    