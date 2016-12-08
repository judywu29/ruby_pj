##Toy Robot Simulator

This is an application that simulates a toy robot moving on a tabletop using the Ruby programming language.

###Usage

Toy Robot Simulator reads instructions from STDIN, executing them one at a time until EOF is reached. 
There are no other obstructions on the table surface. The robot is free to roam around the surface of the table. 
Any movement that would result in the robot falling from the table will be prevented, however further valid 
movement commands are still allowed.

The instructions can be: 

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
The origin (0,0) is considered to be the SOUTH WEST most corner. The first valid command to the robot is a PLACE command, 
after that, any sequence of commands can be issued, in any order, including another PLACE command. 
The application will discard all commands in the sequence until a valid PLACE command has been executed.

- MOVE will move the toy robot one unit forward in the direction it is currently facing.

- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

- REPORT will STDOUT the X,Y and F of the robot.

###Installing

Ensure you have Git and Ruby 2.2.2 installed. Optionally, install rbenv to manage Ruby versions, and editorconfig for 
automatic editor configuration.

Then, in a console execute:

	git clone git@bitbucket.org:jd_wu/toy_robot.git
	cd toy-robot
	gem install bundler
	bundle install

###Supported operating systems

toy-robot should install on pretty much any recent Linux or OSX operating system. 
	
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

####Repository and Implementation

######toyrobot.rb

This file is to capture the command from the STDIN and create the instance to let it handle the commands. 


######simulator.rb

This is a source file where an new class is defined: 

- class Simulator: acts as a proxy class to parse, filter and dispatch the stdin instructions. It will do basic match
about the instructions and will dynamically dispatch the instructions to Robot to handle if it's valid. 

######robot.rb

This is a source file where Robot classe is defined: 

- class Robot: the real object to handle those instructions. There are 5 methods defined to map the instructions from STDIN. 
The class instance variable: @position_info will store the robot position and direction which can be used for the next 
instruction to use.
Be noticed, the MovingStrategy is defined about the moving strategy in each direction in x, y dimentions, the way of moving 
can be got dynamically by its direction. 

######spec/robot_spec.rb

It is a unit testing file to test each method defined in Robot class
 
######spec/simulator_spec.rb
It is a unit testing file to test each method defined in Simulator class 

StringIO exists as a way to make an IO that we can muck around with more easily for testing. To provide input to StringIO, 
we pass a string to its constructor. To check the output to StringIO, a method: capture_stdout defined to capture the output. 

#####test/simulator_integration_spec.rb

It is an integration testing file to test the Simulator and Robot classes. 


###Supported Ruby Versions

Ruby 2.2


###Example Input and Output

#### Example a

    PLACE 0,0,NORTH
    MOVE
    REPORT

	Output:

    The current location is 0,1,NORTH

#### Example b

    PLACE 0,0,NORTH
    LEFT
    REPORT

	Output:

    The current location is 0,0,WEST

#### Example c

    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT

	Output: 

    The current location is 3,3,NORTH

###Contact

Judy Wu, judy.wu29@gmail.com
