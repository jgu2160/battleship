require_relative "battleship"

class MediumBattleship < Battleship
	attr_reader :user_map, :opponent_map, :user_evaluator
	attr_accessor :first_time, :opponent_ship_1x2, :opponent_ship_1x3

	def initialize
		@user_ship_1x2 = Ship.new(nil, 6)
		@user_ship_1x3 = Ship.new(nil, 6)
		@user_ship_1x4 = Ship.new(nil, 6)

		@opponent_ship_1x2 = Ship.new(nil, 6)
		@opponent_ship_1x2.random_1x2
    @opponent_ship_1x3 = Ship.new(@opponent_ship_1x2.coordinates, 6)
		@opponent_ship_1x3.random_1xSize(3)
		@opponent_ship_1x4 = Ship.new(@opponent_ship_1x2.coordinates + @opponent_ship_1x3.coordinates, 6)
		@opponent_ship_1x4.random_1xSize(4)

		@user_map = Map.new(6)
		@opponent_map = Map.new(6)

		@user_evaluator = Evaluator.new(@opponent_ship_1x2, @opponent_ship_1x3, @opponent_ship_1x4, nil, @opponent_map)
		@opponent_evaluator = Evaluator.new(@user_ship_1x2, @user_ship_1x3, @user_ship_1x4, nil, @user_map)
	
		@first_time = true
		@second_time = false
		@third_time = false
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
			@third_time = true
			self.user_input_second_boat
		elsif @third_time == true
			puts Printer.third_boat_loop
			@third_time = false
			self.user_input_third_boat
		else
			puts Printer.guess_opponent_coordinate
			self.user_guess
		end
	end

	def validate_input(aString)
		upcased = aString.upcase
		if upcased[/[ABCDEF][123456]/] && upcased.length == 2
			return upcased[0..1]
		elsif aString == "q"
			$user_choice = "q"
		else
			input_invalid = true
			while input_invalid
				puts Printer.invalid_input
				upcased = gets.chomp.upcase
				if upcased[/[ABCDEF][123456]/]
					input_invalid=false
				end
			end
		end
		upcased[0..1]
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

		unless @user_ship_1x3.straight?(@user_ship_1x3.coordinates)
			@first_time = false
			@second_time = true
			puts Printer.not_in_line
			self.prompt_user
		end
		self.prompt_user
	end

	def user_input_third_boat
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

		puts Printer.next_coordinate
		to_validate_4 = gets.chomp
		validated_4 = self.validate_input(to_validate_4)
		fourth_coordinate = validated_4

		@user_ship_1x4.coordinates[0] = first_coordinate
		@user_ship_1x4.coordinates[1] = second_coordinate
		@user_ship_1x4.coordinates[2] = third_coordinate
		@user_ship_1x4.coordinates[3] = fourth_coordinate

		unless @user_ship_1x4.straight?(@user_ship_1x4.coordinates)
			@second_time = false
			@third_time = true
			puts Printer.not_in_line
			self.prompt_user
		end

		self.mark_initial_ship_position_on_map
		self.show_user_map
		puts Printer.prompt_first_guess
		self.prompt_user
	end

	def mark_initial_ship_position_on_map
		super
		@user_ship_1x4.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🐳")
		end
	end

	def show_user_map
		super
		@user_ship_1x4.sunk == 1 ? puts(Printer.comp_one_by_four_sunk) : nil
	end

	def show_opponent_map
		super
		@opponent_ship_1x4.sunk == 1 ? puts(Printer.one_by_four_sunk) : nil
	end

	def computer_guess
		computer_coordinate = ["A", "B", "C", "D", "E", "F"].sample + rand(1..6).to_s
		unless self.already_guessed(computer_coordinate, @opponent_evaluator)
			self.guess(computer_coordinate, @opponent_evaluator)
		end
	end

	def guess(aGuess, evaluator)
		hit_or_not = evaluator.hit(aGuess)
		if evaluator == @user_evaluator
			hit_or_not ?  puts("\n" + Printer.user_guess_right) : puts("\n" + Printer.user_guess_wrong)
			self.show_opponent_map
			puts "\n"
			self.computer_guess
			self.show_user_map
			puts "\n"
			if @opponent_ship_1x2.sunk + @opponent_ship_1x3.sunk + @opponent_ship_1x4.sunk == 3
				self.win_game
			elsif @user_ship_1x2.sunk + @user_ship_1x3.sunk + @user_ship_1x4.sunk == 3
				self.lose_game
			else
				self.prompt_user
			end
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



class HardBattleship < Battleship
	attr_reader :user_map, :opponent_map, :user_evaluator
	attr_accessor :first_time, :opponent_ship_1x2, :opponent_ship_1x3

	def initialize
		@user_ship_1x2 = Ship.new(nil, 8)
		@user_ship_1x3 = Ship.new(nil, 8)
		@user_ship_1x4 = Ship.new(nil, 8)
		@user_ship_1x5 = Ship.new(nil, 8)

		@opponent_ship_1x2 = Ship.new(nil, 8)
		@opponent_ship_1x2.random_1x2
    @opponent_ship_1x3 = Ship.new(@opponent_ship_1x2.coordinates, 8)
		@opponent_ship_1x3.random_1xSize(3)
		@opponent_ship_1x4 = Ship.new(@opponent_ship_1x2.coordinates + @opponent_ship_1x3.coordinates, 8)
		@opponent_ship_1x4.random_1xSize(4)
		@opponent_ship_1x5 = Ship.new(@opponent_ship_1x2.coordinates + @opponent_ship_1x3.coordinates + @opponent_ship_1x4.coordinates, 6)
		@opponent_ship_1x5.random_1xSize(5)

		@user_map = Map.new(8)
		@opponent_map = Map.new(8)

		@user_evaluator = Evaluator.new(@opponent_ship_1x2, @opponent_ship_1x3, @opponent_ship_1x4, @opponent_ship_1x5, @opponent_map)
		@opponent_evaluator = Evaluator.new(@user_ship_1x2, @user_ship_1x3, @user_ship_1x4, @user_ship_1x5, @user_map)
	
		@first_time = true
		@second_time = false
		@third_time = false
		@fourth_time = false
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
			@third_time = true
			self.user_input_second_boat
		elsif @third_time == true
			puts Printer.third_boat_loop
			@third_time = false
			@fourth_time = true
			self.user_input_third_boat
		elsif @fourth_time == true
			puts Printer.fourth_boat_loop
			@fourth_time = false
			self.user_input_fourth_boat
		else
			puts Printer.guess_opponent_coordinate
			self.user_guess
		end
	end

	def validate_input(aString)
		upcased = aString.upcase
		if upcased[/[ABCDEFGH][12345678]/] && upcased.length == 2
			return upcased[0..1]
		elsif aString == "q"
			$user_choice = "q"
		else
			input_invalid = true
			while input_invalid
				puts Printer.invalid_input
				upcased = gets.chomp.upcase
				if upcased[/[ABCDEFGH][12345678]/]
					input_invalid=false
				end
			end
		end
		upcased[0..1]
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

		unless @user_ship_1x3.straight?(@user_ship_1x3.coordinates)
			@first_time = false
			@second_time = true
			puts Printer.not_in_line
			self.prompt_user
		end
		self.prompt_user
	end

	def user_input_third_boat
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

		puts Printer.next_coordinate
		to_validate_4 = gets.chomp
		validated_4 = self.validate_input(to_validate_4)
		fourth_coordinate = validated_4

		@user_ship_1x4.coordinates[0] = first_coordinate
		@user_ship_1x4.coordinates[1] = second_coordinate
		@user_ship_1x4.coordinates[2] = third_coordinate
		@user_ship_1x4.coordinates[3] = fourth_coordinate

		unless @user_ship_1x4.straight?(@user_ship_1x4.coordinates)
			@second_time = false
			@third_time = true
			puts Printer.not_in_line
			self.prompt_user
		end
		self.prompt_user
	end

	def user_input_fourth_boat
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

		puts Printer.next_coordinate
		to_validate_4 = gets.chomp
		validated_4 = self.validate_input(to_validate_4)
		fourth_coordinate = validated_4

		puts Printer.next_coordinate
		to_validate_5 = gets.chomp
		validated_5 = self.validate_input(to_validate_5)
		fifth_coordinate = validated_5

		@user_ship_1x5.coordinates[0] = first_coordinate
		@user_ship_1x5.coordinates[1] = second_coordinate
		@user_ship_1x5.coordinates[2] = third_coordinate
		@user_ship_1x5.coordinates[3] = fourth_coordinate
		@user_ship_1x5.coordinates[4] = fifth_coordinate

		unless @user_ship_1x4.straight?(@user_ship_1x4.coordinates)
			@third_time = false
			@fourth_time = true
			puts Printer.not_in_line
			self.prompt_user
		end

		self.mark_initial_ship_position_on_map
		self.show_user_map
		puts Printer.prompt_first_guess
		self.prompt_user
	end

	def mark_initial_ship_position_on_map
		super
		@user_ship_1x4.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🐳")
		end
		@user_ship_1x5.coordinates.each do |coordinate|
			@user_map.grid_mark(coordinate, "🐋")
		end
	end

	def show_user_map
		super
		@user_ship_1x4.sunk == 1 ? puts(Printer.comp_one_by_four_sunk) : nil
		@user_ship_1x5.sunk == 1 ? puts(Printer.comp_one_by_five_sunk) : nil
	end

	def show_opponent_map
		super
		@opponent_ship_1x4.sunk == 1 ? puts(Printer.one_by_four_sunk) : nil
		@opponent_ship_1x5.sunk == 1 ? puts(Printer.one_by_five_sunk) : nil
	end

	def computer_guess
		computer_coordinate = ["A", "B", "C", "D", "E", "F", "G", "H"].sample + rand(1..8).to_s
		unless self.already_guessed(computer_coordinate, @opponent_evaluator)
			self.guess(computer_coordinate, @opponent_evaluator)
		end
	end

	def guess(aGuess, evaluator)
		hit_or_not = evaluator.hit(aGuess)
		if evaluator == @user_evaluator
			hit_or_not ?  puts("\n" + Printer.user_guess_right) : puts("\n" + Printer.user_guess_wrong)
			self.show_opponent_map
			puts "\n"
			self.computer_guess
			self.show_user_map
			puts "\n"
			if @opponent_ship_1x2.sunk + @opponent_ship_1x3.sunk + @opponent_ship_1x4.sunk + @opponent_ship_1x5.sunk== 4
				self.win_game
			elsif @user_ship_1x2.sunk + @user_ship_1x3.sunk + @user_ship_1x4.sunk + @user_ship_1x5.sunk == 4
				self.lose_game
			else
				self.prompt_user
			end
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

