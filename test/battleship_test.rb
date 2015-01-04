require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class BattleshipTest < MiniTest::Test
	def setup
		@battleship = Battleship.new
	end

	def test_it_exists
		assert @battleship
	end

	# def test_it_marks_initial_user_position_on_map
	# 	@battleship.mark_initial_ship_position_on_map
	# 	puts @battleship.user_map.grid_array
	# 	puts @battleship.opponent_map.grid_array
	# end

	def test_it_validates_user_inputs
		assert_equal "C2", @battleship.validate_input("C2")
		# assert_equal Printer.invalid_input, @battleship.validate_input("CC")
	end

	# def test_it_registers_and_shows_successful_guesses
	# 	@battleship.mark_initial_ship_position_on_map
	# 	@battleship.opponent_ship_1x2.coordinates = ["A1", "A2"]
	# 	@battleship.opponent_ship_1x3.coordinates = ["B1", "B2", "B3"]
	#  	@battleship.guess("A1",@battleship.user_evaluator)
	#  	@battleship.guess("B4",@battleship.user_evaluator)
	# end

	# def test_it_loops_for_repeat_guesses	
	#  	@battleship.user_evaluator.guess_record = ["A1","A2"]
	#  	@battleship.user_guess
	# end

	def test_it_outputs_the_user_sunk_status
		@battleship.mark_initial_ship_position_on_map
		@battleship.opponent_ship_1x2.coordinates = ["A1", "A2"]
		@battleship.opponent_ship_1x3.coordinates = ["B1", "B2", "B3"]
	 	@battleship.guess("A1",@battleship.user_evaluator)
	 	@battleship.guess("A2",@battleship.user_evaluator)
	 	@battleship.guess("B1",@battleship.user_evaluator)
	 	@battleship.guess("B2",@battleship.user_evaluator)
		@battleship.guess("B3",@battleship.user_evaluator)
	end
end