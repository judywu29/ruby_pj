require 'spec_helper'
require_relative '../player'

module TicTacToe
  describe Player do
    context "#initialize" do
      
      it 'raises an exception  when initialize with {}' do
        expect{ Player.new({}) }.to raise_error
      end
      
      it "doesn't raise an excpeiton when initialized with a valid input hash" do
        input = {color: "X", name: "Someone"}
        expect{ Player.new(input) }.to_not raise_error
      end
      
      it "returns the player's color" do
        input = {color: "X", name: "Someone"}
        player = Player.new(input)
        expect(player.color).to eq "X"
      end
      
       it "returns the player's name" do
        input = {color: "X", name: "Someone"}
        player = Player.new(input)
        expect(player.name).to eq "Someone"
      end
    end
  end
end