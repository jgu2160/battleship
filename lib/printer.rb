module Printer
	def self.invalid_input
		"Please enter a valid letter-number combination."
	end

	def self.first_boat_loop
		"Please enter the coordinates for your dolphins (1x2). Please do one coordinate at a time. They must be in a line."
	end

	def self.second_boat_loop
		"Please enter the coordinates for your whales (1x3). Please do one coordinate at a time. They must be in a line."
	end

	def self.next_coordinate
		"Next coordinate?"
	end

	def self.welcome
		"Welcome to EAT THE OCEAN.\nWould you like to (p)lay, read the (i)nstructions, or
		(q)uit?"
	end

	def self.user_guess_right
		"You scored a meal! You're closer to starving your opponent"
	end

	def self.user_guess_wrong
		"You missed the catch. Too bad."
	end

	def self.comp_guess_right
		"Looks like the computer harvested a critter. Do androids even like blubber?"
	end

	def self.comp_guess_wrong
		"The computer was too random and missed."
	end

	def self.user_map
		"This is your ocean:"
	end

	def self.opponent_map
		"Here's how you've done against the computer:"
	end

	def self.you_win
		"You have turned all the marine life in your opponent's ocean into sushi. Congrats and bon appetit!"
	end

	def self.instructions
		"The goal of EAT THE OCEAN is to guess the location of your opponent's swimming mammals, dolphins (🐬) taking up 1x2 spaces and whales (🐋) taking up 1x3 spaces on a 4x4 grid. Enter any coordinates in the form of 'LETTERnumber', letters A-D and numbers 1-4. The goal is to eat your opponent's entire ocean before it can eat yours. All animals turn into sushi (🍣) upon being discovered. Missed animals are represented by disruptions in the water, water droplets (💦)."
	end

	def self.whats_your_guess
		"What's your guess?"
	end

	def self.prompt_first_guess
		"Now you may begin the guessing game."
	end
end
