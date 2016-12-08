

module Inputfilereading
#store the args of PLACE args
@@place_args = Array.new
#store the cmds except PLACE
@@cmdlist = Array.new

    #reading the input file which is supposed to be at the folder with this ruby file
    def readinginputfile()

        begin
            File.open("input.txt", "r") do |file|
                while line = file.gets
                    case line
                    #format like: PLACE 1,2,EAST
                    when /\A\s*PLACE\s(\d+)\,(\d+)\,(\w+)/
                        @@place_args[0] = $1.to_i
                        @@place_args[1] = $2.to_i
                        @@place_args[2] = $3

                    #format: spaces can be have in front of the cmd, but no other characters on the left and right of it
                    when /\A\s*LEFT$|\A\s*RIGHT$|\A\s*MOVE$|\A\s*REPORT$/
                        @@cmdlist.push(line.chomp.strip)
                        puts line
                    end
                    
                end
            end

        rescue StandardError
            puts "Error: Reading Input file failed, please add the input file. "
            0
        else 
            # puts @@place_args.size
            if @@place_args.empty?
                puts "Error: Please put the Robot on the table first. "
                0
            else 1
            end 
                       
        end
    end
end



class Table
    attr_reader :table_x, :table_y
    def initialize(x, y)
        @table_x = x
        @table_y = y

    end
end


class Robot
    # attr_reader :pos_x, :pos_y, :direction, :step #for test
    include Inputfilereading

    #4 directions used now
    @@directions = ["NORTH", "EAST", "SOUTH", "WEST"]
    
    STEP = 1

    def initialize()    
    end


    #Robot has to be put on the table and unless can move
    def start(table_x, table_y)
        #puts readinginputfile()
        #Reading the input file, create the table and Robot and then move the Robot.
        return 0 if readinginputfile() == 0

        @pos_x = @@place_args[0]
        @pos_y = @@place_args[1]

        @table_x = table_x
        @table_y = table_y
        if  @pos_x >= @table_x or @pos_y >= @table_y
            puts "Error: Robot is not placed on the table. "
            return 0
        end

        @direction = @@place_args[2]
        if not @@directions.include?(@direction)
            puts "Error: Robot can only move towards the four directions. "
            return 0
        end

        return 1


    end

    #move the Robot
    def move()
        # puts @@cmdlist.size
        @@cmdlist.each{|cmd|
            
            if cmd == "LEFT" or cmd == "RIGHT"
                #puts cmd
                update_direction(cmd)

            elsif cmd == "MOVE"
                if not next?()
                    puts "Warning: Robot cannot move towards #{@direction} or else would fall. "
                end
            
            elsif cmd == "REPORT" 
                puts "Report: The final location of Robot is #{@pos_x}, #{@pos_y}, #{@direction}"
            end

             # puts "Report: The final destination of Robot is #{@pos_x}, #{@pos_y}, #{@direction}"
               
        }

    end

    private
        #check if the next position is available to avoid Robot falling down
        def next?()
            case @direction
            when "NORTH"
                return false if @pos_y+STEP > @table_y
                @pos_y += STEP
                return true
            
            when "EAST"
                return false if @pos_x+STEP > @table_x
                @pos_x += STEP
                return true
            
            when "SOUTH"
                return false if @pos_y-STEP < 0
                @pos_y -= STEP
                return true
            
            when "WEST"
                return false if @pos_x-STEP < 0
                @pos_x -= STEP
                return true
            
            end
            return false
        end

        #update the direction when execute the "LEFT, RIGHT" cmd
        def update_direction(moving_direction)
            #looking for the left elem
            if moving_direction == "LEFT"
                if @@directions.first == @direction
                    @direction =  @@directions.last;
                else @direction = @@directions[@@directions.index(@direction) - 1]
                end
            elsif moving_direction == "RIGHT" #looking for the right elem
                if @@directions.last == @direction
                    @direction =  @@directions.first
                else @direction = @@directions[@@directions.index(@direction) + 1]
                end
            end
            
        end

end


#puts $cmdlist.length
table_forfun = Table.new(5, 5) # the units of the table can be set
rob = Robot.new()
if not rob.nil? and not table_forfun.nil? and not rob.start(table_forfun.table_x, table_forfun.table_y) == 0
    rob.move()
end
