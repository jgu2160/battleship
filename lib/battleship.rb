require_relative "evaluator"
require_relative "printer"
require_relative "map"
require 'byebug'

class Battleship
	attr_reader :user_map

	def initialize
		@user_ship_1x2 = Ship.new
		@user_ship_1x3 = Ship.new
		@user_ship_1x3.coordinates = ["B1", "B2", "B3"]

		@opponent_ship_1x2 = Ship.new
		@opponent_ship_1x2.random_1x2
		@opponent_ship_1x3 = Ship.new(@opponent_ship_1x2)
		@opponent_ship_1x3.random_1x3

		@user_map = Map.new(4)
		@opponent_map = Map.new(4)

		@user_evaluator = Evaluator.new(@opponent_ship_1x2, @opponent_ship_1x3)
		@opponent_evaluator = Evaluator.new(@user_ship_1x2, @user_ship_1x3)
	end

	def mark_initial_ship_position_on_map
		@user_ship_1x2.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🚣")
		end

		@user_ship_1x3.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🚤")
		end
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
