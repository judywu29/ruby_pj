require_relative 'cell'
require_relative 'core_extensions'

module TicTacToe
  class Board
    attr_reader :grid
    def initialize input = {}
      @grid = input.fetch(:grid, default_grid)
    end
    
    def get_cell x, y
      @grid[y][x]
    end
    
    def set_cell x, y, value
      get_cell(x, y).value = value #the value is instance memeber of Cell
    end
    
    def game_over
      return :winner if winner?
      return :draw if draw?
      return false
    end
    
    def formatted_grid
      @grid = default_grid
    end
    
    private
    def default_grid
      Array.new(3){ Array.new(3) { Cell.new } }
    end
    
    #check if all of the possible positions with X or O
    def winner?
      winning_positions.each do |winning_position|
        values = winning_position_values(winning_position)
        next if values.all_empty?
        return true if values.all_same?
      end
      return false #has to be return false, once we use return somewhere else
    end
    

    def winning_position_values(winning_position)
      # p "winning_position"
      winning_position.map{ |cell| cell.value }
    end
    
    #there are 8 possible winning positions in tic-tac-toe: 3 rows, 3 cols and 2 diagonals. 
    def winning_positions
      @grid + #rows
      @grid.transpose + #columns
      diagonals #2 diagonals
    end
    
    def diagonals
      [
        [get_cell(0, 0), get_cell(1,1), get_cell(2, 2)], 
        [get_cell(0, 2), get_cell(1,1), get_cell(2, 0)]
      ]
    end
    
    def draw?
      @grid.flatten.map{ |cell| cell.value }.none_empty?
    end
  end
end























