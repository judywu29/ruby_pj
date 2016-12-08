#Unit Test file
require 'test/unit'
require '/users/mac/desktop/ruby/Robot_moving.rb'

class UT_Table < Test::Unit::TestCase

    def setup
        @tb = Table.new(10, 10)

    end

    def teardown
    end

    def test_table_created_successfully
        # assert_instance_of(Table, @tb, "The tb must be Table")
        # assert_equal(10, @tb.table_x)
        # assert_equal(10, @tb.table_y)
    end
end

class UT_Module < Test::Unit::TestCase
    include Inputfilereading

    def setup
         # @file = File.new("input.txt", "r")
    end

    def teardown
    end
    def test_readinginputfile_run_withoutexception_removing_inputfile
        #delete the input file to test: 
        assert_nothing_thrown("Nothing should be raised. "){
            readinginputfile()

        }

        # assert_not_nil()
    end

    # def test_readinginputfile_run_withoutexception_empty_file

    #     assert_equal(readinginputfile(), 0) #return 0

    #     # assert_not_nil()
    # end

    #PLACE 1,2,EAST
    #MOVE
    #MOVE
    #RIGHT
    #MOVE
    #REPORT
     # def test_readinginputfile_run_successfully
     #     assert_equal(3, @@place_args.size, "The size is 3")
     #     assert_equal(5, @@cmdlist.size, "The size is 5")
     #     assert_equal("MOVE", @@cmdlist[0])
     #     assert_equal("MOVE", @@cmdlist[1])
     #     assert_equal("RIGHT", @@cmdlist[2])
     #     assert_equal("MOVE", @@cmdlist[3])
     #     assert_equal("REPORT", @@cmdlist[4])

     #     assert_equal(readinginputfile(), 1)
     # end

    #PLACE 1,2,EAST
    # MOVE
    #MOVE
    # RIGHT
    #MOVE
    #REPORT
     # def test_readinginputfile_run_successfully_with_space_in_CMD
     #     assert_equal(3, @@place_args.size, "The size is 3")
     #     assert_equal(5, @@cmdlist.size, "The size is 5")
     #     assert_equal("MOVE", @@cmdlist[0])
     #     assert_equal("MOVE", @@cmdlist[1])
     #     assert_equal("RIGHT", @@cmdlist[2])
     #     assert_equal("MOVE", @@cmdlist[3])
     #     assert_equal("REPORT", @@cmdlist[4])

     #     assert_equal(readinginputfile(), 1)
     # end

    ##PLACE 1,2,EAST
    #MOVE
    #MOVE
    #RIGHT
    #MOVE
    #REPORT
    # def test_readinginputfile_run_faild_without_PLACE
    #     assert_equal(0, @@place_args.size, "The size is 0")
    #     assert_equal(5, @@cmdlist.size, "The size is 5")

    #     assert_equal(readinginputfile(), 0) #return 0
        
    # end

    #PLACE 1,2,EAST
    ##MOVE
    ##MOVE
    #RIGHT
    ##MOVE
    #REPORT
    # def test_readinginputfile_run_faild_without_MOVE
    #     assert_equal(3, @@place_args.size, "The size is 3")
    #     assert_equal(2, @@cmdlist.size, "The size is 2")
    #     assert_equal("RIGHT", @@cmdlist[0])
    #     assert_equal("REPORT", @@cmdlist[1])

    #     assert_not_equal(readinginputfile(), 0) #return 0
        
    # end

    #PLACE 1,2,EAST
    #MOVE
    #MOVE
    #RIGHTAAA
    #MOVE
    #REPORTBB
    # def test_readinginputfile_run_faild_with_wrong_CMD
    #     assert_equal(3, @@place_args.size, "The size is 3")
    #     assert_equal(3, @@cmdlist.size, "The size is 3")
    #     assert_equal("MOVE", @@cmdlist[0])
    #     assert_equal("MOVE", @@cmdlist[1])
    #     assert_equal("MOVE", @@cmdlist[2])
    #     assert_equal(1, @@step)

    #     assert_not_equal(readinginputfile(), 0) #return 0
        
    # end


end

class UT_Robot < Test::Unit::TestCase

    def setup
        @rbt = Robot.new()
        @tb = Table.new(5, 5)


    end

    def teardown
    end

    def test_Robot_created_successfully
        # assert_instance_of(Robot, @rbt, "The rbt must be Robot")
    end

    # # PLACE 1,2,EAST
    #   MOVE
    # MOVE
    #   RIGHT
    # MOVE
    # REPORT
    #comment PLACE Order to trigger
    # def test_Robot_start_faild_readinginputfile_faild
    #     assert_equal(0, @rbt.start(5,5))

    # end

    #PLACE 1,2,EAST
    #MOVE
    #MOVE
    #RIGHT
    #MOVE
    #REPORT
    # def test_Robot_start_successfully
    #     assert_equal(1, @rbt.start(5,5))
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal("EAST", @rbt.direction)
    # end

    #testing faild cases:
    #PLACE 6,2,EAST
    #MOVE
    #MOVE
    #RIGHT
    #MOVE
    #REPORT
    # def test_Robot_start_faild_with_wrong_position
    #     assert_equal(0, @rbt.start(5,5))
    #     assert_equal(6, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_nil(@rbt.direction)
    # end

    #PLACE 1,2,AAAA
    #MOVE
    #MOVE
    #RIGHT
    #MOVE
    #REPORT
    # def test_Robot_start_faild_with_wrong_direction
    #     assert_equal(0, @rbt.start(5,5))
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal("AAAA", @rbt.direction)


    # end
    # PLACE 1,2,EAST
    # RIGHT
    #has to change the access control from private to public to test
    # def test_move_update_direction_case1_run_successfully
        
    #     assert_equal("EAST", @rbt.direction)
    #     @rbt.update_direction("RIGHT")
    #     assert_equal("SOUTH", @rbt.direction)
    # end
    # PLACE 1,2,EAST
    # LEFT
    # def test_move_update_direction_case2_run_successfully
        
    #     assert_equal("EAST", @rbt.direction)
    #     @rbt.update_direction("LEFT")
    #     assert_equal("NORTH", @rbt.direction)
    # end

    # # PLACE 1,2,WEST
    # # LEFT
    # def test_move_update_direction_case3_run_successfully
        
    #     assert_equal("WEST", @rbt.direction)
    #     @rbt.update_direction("LEFT")
    #     assert_equal("SOUTH", @rbt.direction)
    # end

    # def test_move_update_direction_case4_run_successfully
        
    #     assert_equal("WEST", @rbt.direction)
    #     @rbt.update_direction("RIGHT")
    #     assert_equal("NORTH", @rbt.direction)
    # end

    # def test_move_update_direction_case5_run_successfully
        
    #     assert_equal("NORTH", @rbt.direction)
    #     @rbt.update_direction("RIGHT")
    #     assert_equal("EAST", @rbt.direction)
    # end
    # PLACE 1,2,NORTH
    # LEFT
    # def test_move_update_direction_case6_run_successfully
        
    #     assert_equal("NORTH", @rbt.direction)
    #     @rbt.update_direction("LEFT")
    #     assert_equal("WEST", @rbt.direction)
    # end

    # # PLACE 1,2,SOUTH
    # # LEFT
    # def test_move_update_direction_case7_run_successfully
        
    #     assert_equal("SOUTH", @rbt.direction)
    #     @rbt.update_direction("LEFT")
    #     assert_equal("EAST", @rbt.direction)
    # end

    # def test_move_update_direction_case8_run_successfully
        
    #     assert_equal("SOUTH", @rbt.direction)
    #     @rbt.update_direction("RIGHT")
    #     assert_equal("WEST", @rbt.direction)
    # end

    # def test_move_update_direction_run_with_wrong_input
        
    #     assert_equal("SOUTH", @rbt.direction)
    #     @rbt.update_direction("AAAA")
    #     assert_equal("SOUTH", @rbt.direction) #no change to make
    # end

    ##################################test next?()###########################

    #####test the previous step is inside the table, and it can move to next position
    # def test_next_run_move_to_south_successfully
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal(true, @rbt.next?())
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(1, @rbt.pos_y)

    # end
    #  def test_next_run_move_to_east_successfully
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal(true, @rbt.next?())
    #     assert_equal(2, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)

    # end

    # def test_next_run_move_to_north_successfully
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal(true, @rbt.next?())
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(3, @rbt.pos_y)

    # end

    # def test_next_run_move_to_west_successfully
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal(true, @rbt.next?())
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)

    # end

    #######begin to test the original position at the border of each direction, next move should not taken########
    # def test_next_run_unable_to_move_to_south_successfully
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(0, @rbt.pos_y)
    #     assert_equal(false, @rbt.next?())
    #     assert_equal(1, @rbt.pos_x)
    #     assert_equal(0, @rbt.pos_y)

    # end
    #  def test_next_run_unable_to_move_to_east_successfully
    #     assert_equal(5, @rbt.pos_x)
    #     assert_equal(0, @rbt.pos_y)
    #     assert_equal(false, @rbt.next?())
    #     assert_equal(5, @rbt.pos_x)
    #     assert_equal(0, @rbt.pos_y)

    # end

    # def test_next_run_uable_to_move_to_north_successfully
    #     assert_equal(2, @rbt.pos_x)
    #     assert_equal(5, @rbt.pos_y)
    #     assert_equal(false, @rbt.next?())
    #     assert_equal(2, @rbt.pos_x)
    #     assert_equal(5, @rbt.pos_y)

    # end

    # def test_next_run_unable_to_move_to_west_successfully
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(3, @rbt.pos_y)
    #     assert_equal(false, @rbt.next?())
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(3, @rbt.pos_y)
    # end
    #######end to test the original position at the border of each direction, next move should not taken########
    
    #######start to test move method##################################
    # PLACE 0,3,WEST
    # LEFT
    # MOVE
    # LEFT
    # REPORT
    # def test_move_run_case1_successfully
    #     @rbt.start(5,5)
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(3, @rbt.pos_y)
    #     assert_equal("WEST", @rbt.direction)
    #     @rbt.move()
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(2, @rbt.pos_y)
    #     assert_equal("EAST", @rbt.direction)

    # end
    # PLACE 0,3,WEST
    # RIGHT
    # MOVE
    # RIGHT
    # REPORT
    # def test_move_run_case2_successfully
    #     @rbt.start(5,5)
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(3, @rbt.pos_y)
    #     assert_equal("WEST", @rbt.direction)
    #     @rbt.move()
    #     assert_equal(0, @rbt.pos_x)
    #     assert_equal(4, @rbt.pos_y)
    #     assert_equal("EAST", @rbt.direction)


    
    
end
