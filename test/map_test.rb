require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class MapTest < MiniTest::Test
	def setup
		@map = Map.new(4)
	end

	# def test_it_exists
	# 	assert @map
	# end

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

	def test_it_places_marks
		@map.grid_create
		@map.border_create
		@map.grid_mark("A1", "🐋")
		@map.grid_mark("A2", "🐋")
		@map.grid_mark("A3", "🍣")
		@map.grid_mark("B1", "🐬")
		@map.grid_mark("B2", "🐬")
		@map.grid_mark("D1", "🐬")
		@map.grid_mark("D2", "🍣")
		@map.grid_mark("D3", "💦")
		puts @map.grid_array
	end
end