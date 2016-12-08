require_relative 'game'
require_relative 'player'



puts "Welcome to tic tac toe"
bob = TicTacToe::Player.new( {color: "X", name: "bob"})
frank = TicTacToe::Player.new({color: "O", name: "frank"})
players = [bob, frank]
TicTacToe::Game.new(players).play
