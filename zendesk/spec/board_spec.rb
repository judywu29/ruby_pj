require 'spec_helper'
require_relative '../tic_tac_toc'

describe Board do
  let(:board) { Board.new(6) }
  
  describe '#initialize' do
      
      it 'sets the board size' do
        expect(board.board_x).to eq 6
        expect(board.board_y).to eq 6
      end
      
    end
    
   describe '#square_is' do
     before do
      board.square_is(0, 0, 'X') 
     end
     it 'moves one step' do
      
      expect(board.players_positions).to eq({:X=>[[0,0]] } )
     end
     it 'warns the customer that the position is outside the board' do
        expect{ board.square_is(7, 0, 'X') }.to output("Out of bounds, try another position\n").to_stdout
      end
     it 'warns the customer that the Invalid player' do
        expect{ board.square_is(0, 0, 'S') }.to output("Invalid player\n").to_stdout
     end
     it "warns the customer that Cell occupied, try another position" do
       expect{ board.square_is(0, 0, 'X') }.to output("Cell occupied, try another position\n").to_stdout
     end
      
   end
   
   describe "#winner" do
     subject do
       board.square_is(0, 0, 'X') 
       board.square_is(1, 1, 'X')
       board.square_is(1, 0, 'O')
       board.square_is(0, 1, 'X')
       board.square_is(2, 1, 'O')
       board.winner 
     end
     
     it "returns the 'X' as winner" do
       
       expect(subject).to eq('X')
     end
     
     it "returns the 'O' as winner" do
       
       expect(subject).to eq('O')
     end
     
     it "reports nil when there's no winner" do
       expect(subject).to eq(nil)
     end
   end
end