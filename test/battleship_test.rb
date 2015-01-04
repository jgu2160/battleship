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

	def test_it_marks_initial_user_position_on_map
		@battleship.mark_initial_ship_position_on_map
		puts @battleship.user_map.grid_array
		puts @battleship.opponent_map.grid_array
	end

	def test_it_validates_user_inputs
		assert_equal "C2", @battleship.user_input_one_coordinate("C2")
		assert_equal Printer.invalid_input, @battleship.user_input_one_coordinate("CC")
	end

	def test_it_register_and_shows_successful_guesses
	 	
	end 		
end