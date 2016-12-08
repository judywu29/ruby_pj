

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
                puts "Error: Please put the Robot on the table. "
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

class Action

    def play(rbt)
    end
end

class Left < Action
    include Inputfilereading

    def play(rbt)
        if @@directions.first == rbt.direction
            rbt.direction =  @@directions.last;
        else rbt.direction = @@directions[@@directions.index(rbt.direction) - 1]
        end
    end


end

class Right < Action
    include Inputfilereading

    def play(rbt)
        if @@directions.last == rbt.direction
            rbt.direction =  @@directions.first
        else rbt.direction = @@directions[@@directions.index(rbt.direction) + 1]
        end
    end


end

class Move < Action

    STEP = 1

    def play(rbt)
        case rbt.direction
        when "NORTH"
            return false if rbt.pos_y+STEP > rbt.table_y
            rbt.pos_y += STEP
            return true
            
        when "EAST"
            return false if rbt.pos_x+STEP > rbt.table_x
            rbt.pos_x += STEP
            return true
            
        when "SOUTH"
            return false if rbt.pos_y-STEP < 0
            rbt.pos_y -= STEP
            return true
            
        when "WEST"
            return false if rbt.pos_x-STEP < 0
            rbt.pos_x -= STEP
            return true
            
        end
        return false

    end

end

class Report < Action

    def play(rbt)
        puts "Report: The final destination of Robot is #{rbt.pos_x}, #{rbt.pos_y}, #{rbt.direction}"
    end
end

class Robot
     attr_accessor :pos_x, :pos_y, :direction #for test
    include Inputfilereading

    #4 directions used now
    @@directions = ["NORTH", "EAST", "SOUTH", "WEST"]


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
            
            if cmd == "LEFT"
                action = Left.new()
            elsif cmd == "RIGHT"
                action = Right.new()
            elsif cmd == "MOVE"
                action = Move.new()
            elsif cmd == "Report"
                action = Report.new()
            end

            action.play(self)
        }

    end

end


#puts $cmdlist.length
table_forfun = Table.new(5, 5) # the units of the table can be set
rob = Robot.new()
if not rob.nil? and not table_forfun.nil? and not rob.start(table_forfun.table_x, table_forfun.table_y) == 0
    rob.move()
end