module Printer
	def self.too_few
		"Please enter more characters."
	end
	def self.too_many
		"Please enter fewer characters."
	end
	def self.invalid_input
		"Please enter a valid 4 character string."
	end
	def self.welcome
		"Welcome to MASTERMIND.\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
	end
	def self.guess_again
		"'RRGB' has 3 of the correct elements with 2 in the correct positionsYou've taken 1 guess."
	end

	def self.first_guess
		"I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.What's your guess?"
	end

	def self.you_win
		"You win! GG."
	end

	def self.instructions
		"Guess the 4 letter string made up of (r)ed, (g)reen, (b)lue, and/or (y)ellow. You will be told how many colors and positions you guessed correctly.\nPlease (p)lay or (q)uit."
	end

	def self.whats_your_guess
		"What's your guess?"
	end
end
