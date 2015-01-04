module Printer
	def self.invalid_input
		"Please enter a valid letter-number combination."
	end

	def self.first_boat_loop
		"Please enter the coordinates for your dolphin (1x2). Please do one coordinate at a time."
	end

	def self.second_boat_loop
		"Please enter the coordinates for your whale (1x3). Please do one coordinate at a time."
	end

	def self.next_coordinate
		"Next coordinate?"
	end

	def self.welcome
		"Welcome to EAT THE OCEAN.\nWould you like to (p)lay, read the (i)nstructions, or
		(q)uit?"
	end

	def self.guess_right
		"You scored a meal!."
	end

	def self.guess_wrong
		"You missed. Too bad."
	end

	def self.opponent_map
		"Here's how you've done against the computer:"
	end

	def self.you_win
		"You win!"
	end

	def self.instructions
		"The goal of EAT THE OCEAN is to guess the location of your opponent's swimming mammals. Enter any coordinates in the form 'LETTERnumber'."
	end

	def self.whats_your_guess
		"What's your guess?"
	end

	def self.user_map
		"This is your map:"
	end

	def self.computer_guess
		"The computer also guessed for this turn."
	end

	def self.prompt_first_guess
		"Now you may begin the guessing game."
	end
end
