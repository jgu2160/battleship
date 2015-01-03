require_relative "evaluator"
require_relative "printer"

class Battleship
	def initialize
		@target_array = Array.new(4){['r','g','b','y'].sample}.join
		@evaluator = Evaluator.new(@target_array)
		@guesses = 0
		@first_time = true
	end

	def prompt_user
		if @first_time == true
			puts Printer.first_guess
			puts Printer.whats_your_guess
			@first_time = false
			self.user_input
		else
			puts Printer.whats_your_guess
			self.user_input
		end
	end

	def user_input
		aString = gets.chomp
		downcased = aString.downcase
		if downcased.length == 4 && downcased[/[rbgy]{4}/]
			self.user_input_valid_string(downcased)
		elsif aString.length > 4
			puts Printer.too_many
			self.prompt_user
		elsif aString == 'q'
			$user_choice = 'q'
		elsif aString.length < 4
			puts Printer.too_few
			self.prompt_user
		else
			puts Printer.invalid_input
			self.prompt_user
		end
	end

	def user_input_valid_string(aString)
		position_matches = @evaluator.match_position(aString)
		color_matches = @evaluator.count_colors(aString)
		@guesses += 1
		if position_matches == aString.length
			puts Printer.you_win
			$user_choice = 'q'
		else
			puts "'#{aString}' has #{color_matches} of the correct colors with #{position_matches} in the correct position. You have taken #{@guesses} guesses."
			self.prompt_user		
		end
	end
end

if __FILE__ == $0
	puts Printer.welcome
	$user_choice
	until $user_choice == "q"
		$user_choice = gets.chomp
		if $user_choice == "p"
			game = Mastermind.new
			game.prompt_user
		elsif $user_choice == "i"
			puts Printer.instructions
		elsif $user_choice == "q"
			puts "Goodbye"
		else
			puts "Please enter a valid string."
		end
	end	
end
