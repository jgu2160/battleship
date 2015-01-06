require_relative "evaluator"
require_relative "printer"
require_relative "ship"
require_relative "map"
require 'byebug'

class Battleship
	attr_reader :user_map, :opponent_map, :user_evaluator
	attr_accessor :first_time, :opponent_ship_1x2, :opponent_ship_1x3

	def initialize
		@user_ship_1x2 = Ship.new
		@user_ship_1x3 = Ship.new

		@opponent_ship_1x2 = Ship.new
		@opponent_ship_1x2.random_1x2
		@opponent_ship_1x3 = Ship.new(@opponent_ship_1x2)
		@opponent_ship_1x3.random_1x3

		@user_map = Map.new(4)
		@opponent_map = Map.new(4)

		@user_evaluator = Evaluator.new(@opponent_ship_1x2, @opponent_ship_1x3, @opponent_map)
		@opponent_evaluator = Evaluator.new(@user_ship_1x2, @user_ship_1x3, @user_map)
	
		@first_time = true
		@second_time = false
	end
 
	def prompt_user
		if @first_time == true
			puts Printer.first_boat_loop
			@first_time = false
			@second_time = true
			self.user_input_first_boat
		elsif @second_time == true
			puts Printer.second_boat_loop
			@second_time = false
			self.user_input_second_boat
		else
			puts Printer.guess_opponent_coordinate
			self.user_guess
		end
	end

	def validate_input(aString)
		upcased = aString.upcase
		if upcased[/[ABCD][1234]/] && upcased.length == 2
			# byebug
			return upcased[0..1]
		elsif aString == "q"
			$user_choice = "q"
		else
			input_invalid = true
			while input_invalid
				puts Printer.invalid_input
				upcased = gets.chomp.upcase
				if upcased[/[ABCD][1234]/]
					input_invalid=false
				end
			end
		end
		upcased[0..1]
	end

	def user_input_first_boat
		to_validate = gets.chomp
		validated = self.validate_input(to_validate)
		first_coordinate = validated

		puts Printer.next_coordinate
		to_validate_2 = gets.chomp
		validated_2 = self.validate_input(to_validate_2)
		second_coordinate = validated_2

		@user_ship_1x2.coordinates[0] = first_coordinate
		@user_ship_1x2.coordinates[1] = second_coordinate

		self.prompt_user
	end

	def user_input_second_boat
		to_validate = gets.chomp
		validated = self.validate_input(to_validate)
		first_coordinate = validated

		puts Printer.next_coordinate
		to_validate_2 = gets.chomp
		validated_2 = self.validate_input(to_validate_2)
		second_coordinate = validated_2

		puts Printer.next_coordinate
		to_validate_3 = gets.chomp
		validated_3 = self.validate_input(to_validate_3)
		third_coordinate = validated_3

		@user_ship_1x3.coordinates[0] = first_coordinate
		@user_ship_1x3.coordinates[1] = second_coordinate
		@user_ship_1x3.coordinates[2] = third_coordinate

		self.mark_initial_ship_position_on_map
		self.show_user_map
		Printer.prompt_first_guess
		self.prompt_user
	end

	def mark_initial_ship_position_on_map
		@user_ship_1x2.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🐬")
		end

		@user_ship_1x3.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🐋")
		end
	end

	def show_user_map
		puts Printer.user_map
		puts @user_map.grid_array
		@user_ship_1x2.sunk == 1 ? puts(Printer.comp_one_by_two_sunk) : nil
		@user_ship_1x3.sunk == 1 ? puts(Printer.comp_one_by_three_sunk) : nil
		puts "\n"
	end

	def show_opponent_map
		puts Printer.opponent_map
		puts @opponent_map.grid_array
		@opponent_ship_1x2.sunk == 1 ? puts(Printer.one_by_two_sunk) : nil
		@opponent_ship_1x3.sunk == 1 ? puts(Printer.one_by_three_sunk) : nil
		puts "\n"
	end

	def already_guessed(coordinate, evaluator)
		#begin janky
		looped = false
		if evaluator.guess_record.include?(coordinate)
			evaluator == @user_evaluator ? puts(Printer.already_guessed) : nil
			looped = true
			self.send(caller[0][/`.*'/][1..-2].to_sym)
		end
		looped
		#end janky
	end

	def user_guess
		user_coordinate = gets.chomp
		validated_coordinate = self.validate_input(user_coordinate)
		self.already_guessed(validated_coordinate, @user_evaluator)
		self.guess(validated_coordinate, @user_evaluator)
	end

	def computer_guess
		computer_coordinate = ["A", "B", "C", "D"].sample + rand(1..4).to_s
		unless self.already_guessed(computer_coordinate, @opponent_evaluator)
			self.guess(computer_coordinate, @opponent_evaluator)
		end
	end

	def guess(aGuess, evaluator)
		hit_or_not = evaluator.hit(aGuess)
		if evaluator == @user_evaluator
			hit_or_not ?  puts("\n" + Printer.user_guess_right) : puts("\n" + Printer.user_guess_wrong)
			self.show_opponent_map
			self.computer_guess
			self.show_user_map

			@opponent_ship_1x2.sunk + @opponent_ship_1x3.sunk == 2 ? self.win_game : self.prompt_user
			@user_ship_1x2.sunk + @user_ship_1x3.sunk == 2 ? self.lose_game : nil
		else
			hit_or_not ? puts(Printer.comp_guess_right) : puts(Printer.comp_guess_wrong + aGuess + ".")
		end
	end

	def win_game
		puts "\n" + "You win this (unethical) game! You defeated the computer in #{@user_evaluator.guess_record.length} moves." + "\n\n"
		$user_choice = "q"
	end

	def lose_game
		puts "\n" + "You lose. The computer demoralized you in #{@opponent_evaluator.guess_record.length} moves." + "\n\n"
		# puts "Play again? (y\\n)"
		# answer = gets.chomp
		# if answer == "y"
		$user_choice = "q"
	end
end

if __FILE__ == $0
	puts Printer.title
	puts Printer.welcome
	$user_choice
	until $user_choice == "q"
		$user_choice = gets.chomp
		if $user_choice == "p"
			game = Battleship.new
			game.prompt_user
		elsif $user_choice == "i"
			puts Printer.instructions
		elsif $user_choice == "q"
			puts "Goodbye!"
		else
			puts "Please enter a valid string."
		end
	end	
end
