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
	end

	# def test_it_generates_borders_of_varying_size
	# 	@map.size = 16
	# 	puts @map.border_create
	# end

	# def test_it_generates_number_line
	# 	puts @map.grid_create
	# end

	# def test_it_generates_the_grid
	# 	@map.grid_create
	# 	@map.border_create
	# 	puts @map.grid_array
	# end
end