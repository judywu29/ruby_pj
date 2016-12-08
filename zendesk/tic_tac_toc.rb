
class Board
  
  #there are 2 players: X or O:
  Players = [:X, :O]
  
  #a 'board', through which the players will play.       attr_reader :board_x, :board_y, :players_positions
  
  def initialize size_length
    @board_x = @board_y = size_length
    @players_positions = {}
  end
  
  #interface to save the position of each player
  def square_is row, col, x_or_o
    player = x_or_o.upcase.to_sym
    puts "Invalid player" unless Players.include? player
    puts "Out of bounds, try another position" unless inside_board? [row, col]
    puts "Cell occupied, try another position" unless position_available? [row, col]
    
    @players_positions[player] << [row, col] 
    
  end
  
  #report the who the winner is
  def winner
    @players_positions.each_pair do |k, v|
       return k.to_s if consecutive?(v.map(&:first)) || consecutive?(v.map(&:last))
    end
    return nil
  end
  
  private
  #check if the position inside board
  def inside_board? position
    (0..@board_x).include?(position.first) && (0..@board_y).include?(position.last)
  end
  
  #check if it's filled
  def position_available? position
    (position & @players_positions.values_at(Players)).nil?
  end
  
  #check if there are 3 consecutive numbers and it's the laest step makes it consecutive
  def consecutive? arr
    arr_dup = arr.dup
    laest_one = arr.last
    arr_dup.sort!
    while arr_dup.size > 2
      first_three = arr_dup.first(3)
      return true if first_three.include? laest_one && arr_dup[1] * 3 == first_three.inject(:+)
      arr_dup.shift
    end
    return false
  end
end
