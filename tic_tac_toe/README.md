Tic-Tac-Toe
================

This application is to build the famous tic-tac-toe game. The board is a n X n grid and players alternate 
turns until one player is victorious or the game ends in a draw. Players win by securing three consecutive 
positions on a row, column, or diagonal. The game ends in a tie if neither player 
has won and all positions on the board are taken.

###Installing

Ensure you have Git and Ruby 2.2.2 installed. Optionally, install rbenv to manage Ruby versions, and editorconfig for 
automatic editor configuration.

Then, in a console execute:

	git clone git@github.com:judywu29/tic_tac_toe.git
	cd tic_tac_toe
	gem install bundler
	bundle install

###Supported operating systems

tic-tac-toe should install on pretty much any recent Linux or OSX operating system. 
	
###Running

Interactively:

	$ ruby toyrobot.rb
	Please type the instructions here:
	place 2,3,east
	move
	left
	move
	move
	report
	The current location is 3,5,NORTH
	
With invalid commands:

 	$ ruby simulator.rb
	Please type the instructions here:
	place 2,3,fake
	Please place robot on the table.
	move     
	Ignoring move until robot is PLACED.
	left
	Ignoring left until robot is PLACED.
	report
	Ignoring report until robot is PLACED.

###Development notes

I made the following assumptions:

- The tabletop can be looked as a square of dimensions 5 units x 5 units by default but can be configured. 
- Lines that are either empty or contain only whitespace can be completely ignored 
- Whitespace in line is valid
- Multiple valid PLACE statements are valid
- Case-Insensitivity was by design (e.g. PLACE or place)
- Abbreviations are not allowed (e.g. NORTH/north but not N)
- Comma separators are required (e.g. 0,0,NORTH but not 0 0 NORTH)

Depending upon the time available and the background of the intended users, some of those assumptions 
could easily be challenged. E.g. Windows users are not used to case sensitivity or silent success.


###Contact

Judy Wu, judy.wu29@gmail.com