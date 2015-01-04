module Printer
	def self.invalid_input
		"Please enter a valid letter-number combination."
	end

	def self.welcome
		"Welcome to BATTLESHIP.\nWould you like to (p)lay, read the (i)nstructions, or
		(q)uit?"
	end

	def self.guess_right
		"You hit scored a hit!."
	end

	def self.guess_wrong
		"You missed. Too bad."
	end

	def self.opponent_status
		"Here's the how you're doing against your opponent:"
	end

	def self.opponent_status
		"Here's your current status:"
	end

	def self.you_win
		"You win! GG."
	end

	def self.instructions
		"The goal of BATTLESHIP is to guess the location of your opponent's ships. Enter your ship coordinates (for a 1x2 ship as an example) as 'LETTERnumber LETTERnumber' and your guess coordinates in the form 'LETTERnumber'."
	end

	def self.whats_your_guess
		"What's your guess?"
	end
end
