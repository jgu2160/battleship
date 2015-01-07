require 'colorize'

module Printer
	def self.invalid_input
		"Please enter a valid letter-number combination."
	end

	def self.first_boat_loop
		"\nPlease enter the coordinates for your octopi (1x2). Please do one coordinate at a time. They must be in a line."
	end

	def self.second_boat_loop
		"\nPlease enter the coordinates for your dolphins (1x3). Please do one coordinate at a time. They must be in a line."
	end

	def self.third_boat_loop
		"\nPlease enter the coordinates for your baby whales (1x4). Please do one coordinate at a time. They must be in a line."
	end

	def self.fourth_boat_loop
		"\nPlease enter the coordinates for your adult whales (1x5). Please do one coordinate at a time. They must be in a line."
	end


	def self.next_coordinate
		"\nNext coordinate?"
	end

	def self.not_in_line
		"\nThat was not in a line!".colorize(:red)
	end

	def self.blocked
		"\nThis ship is overlapping another. Not okay.".colorize(:red)
	end

	def self.title
		"\n" * 60 +
"EEEEEEE   AAA   TTTTTTT  TTTTTTT HH   HH EEEEEEE   OOOOO   CCCCC  EEEEEEE   AAA   NN   NN 
EE       AAAAA    TTT      TTT   HH   HH EE       OO   OO CC    C EE       AAAAA  NNN  NN 
EEEEE   AA   AA   TTT      TTT   HHHHHHH EEEEE    OO   OO CC      EEEEE   AA   AA NN N NN 
EE      AAAAAAA   TTT      TTT   HH   HH EE       OO   OO CC    C EE      AAAAAAA NN  NNN 
EEEEEEE AA   AA   TTT      TTT   HH   HH EEEEEEE   OOOO0   CCCCC  EEEEEEE AA   AA NN   NN ".colorize(:blue)
	end

	def self.welcome
		"\n" * 5 +
		"Would you like to play" + " (e)asy".colorize(:green) + " on a 4x4 grid, " + "(m)edium".colorize(:blue) + " on a 6x6 grid, or " + "(h)ard".colorize(:red) + " on an 8x8 grid? Also, read the (i)nstructions, or (q)uit?"
	end

	def self.user_guess_right
		"\n" * 30 +"You scored a meal! You're closer to starving your opponent."
	end

	def self.user_guess_wrong
		"\n" * 30 + "You missed the catch. Too bad."
	end

	def self.comp_guess_right
		"Looks like the computer harvested a critter. Do androids even like blubber?"
	end

	def self.comp_guess_wrong
		"The computer was too random and missed on "
	end

	def self.user_map
		"This is your ocean:"
	end

	def self.opponent_map
		"Here's how you've done against the computer:"
	end

	def self.you_win
		"You have turned all the marine life in your opponent's ocean into " + "sushi".colorize(:red) + ". Congrats and bon appetit!"
	end

	def self.instructions
		"\n" + 
		"The goal of " + "EAT THE OCEAN".colorize(:blue)+ " is to guess the location of your opponent's swimming mammals," + " octopi".colorize(:red) + "(🐙), taking up 1x2 spaces, " + " dolphins".colorize(:light_blue) +"(🐬), taking up 1x3 spaces," + " baby whales".colorize(:blue) + "(🐳), taking up 1x4 spaces, and" + " adult whales".colorize(:blue) + "(🐋), taking up 1x5 spaces. There are only octopi and dolphins in the easy game (4x4), the addition of baby whales in the medium (6x6), and the further addition of whales in the hard (8x8). Enter any coordinates in the form of 'LETTERnumber', letters A-D and numbers 1-4. The goal is to eat your opponent's entire ocean before it can eat yours. All animals turn into " +"sushi".colorize(:red) + "(🍣) upon being discovered. Missed animals are represented by disruptions in the water," + " water droplets".colorize(:blue) +" (💦). The ocean grid is bordered by " + "big waves".colorize(:blue)+ "(🌊) and "+" Mr. Sun".colorize(:yellow)+" (🌞). Please play " + "(e)asy".colorize(:green) + "," + " (m)edium".colorize(:blue) + ", or " + "(h)ard".colorize(:red) + ". Or (q)uit.\n"
	end

	def self.whats_your_guess
		"What's your guess?"
	end

	def self.prompt_first_guess
		"Now you may begin the guessing game."
	end

	def self.already_guessed
		"You've already guessed this. Please guess again."
	end

	def self.one_by_two_sunk
		"You've eaten all the octopi...:("
	end

	def self.one_by_three_sunk
		"You've eaten all the dolphins...:("
	end

	def self.one_by_four_sunk
		"You've eaten all the baby whales...:("
	end

	def self.one_by_five_sunk
		"You've eaten all the adult whales...:("
	end

	def self.comp_one_by_two_sunk
		"The computer has eaten ALL your octopi...:("
	end

	def self.comp_one_by_three_sunk
		"The computer has eaten ALL your dolphins...:("
	end

	def self.comp_one_by_four_sunk
		"The computer has eaten ALL your baby whales...:("
	end

	def self.comp_one_by_five_sunk
		"The computer has eaten ALL your adult whales...:("
	end

	def self.guess_opponent_coordinate
		"Please guess where the computer's marine life is."		
	end
end
