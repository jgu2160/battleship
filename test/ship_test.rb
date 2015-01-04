require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class ShipTest < MiniTest::Test
	def setup
		@battleship = Battleship.new
		@ship_1x2 = Ship.new
		@ship_1x3 = Ship.new(@ship_1x2)
	end

	def test_it_generates_a_predictable_2x2_ship
		assert_equal ["A1", "A2"], @ship_1x2.coordinates
	end

	def test_it_generates_a_random_1x2_ship
		random_1x2 = Ship.new
		puts random_1x2.random_1x2
	end

	def test_it_generates_a_1x3_not_on_top_of_the_1x2
		puts @ship_1x3.random_1x3
	end

	def test_space_check_checks_spaces_of_existing_ships_given_a_size
		refute @ship_1x3.horz_space_check("A1",3)
		assert @ship_1x3.horz_space_check("B1",3)
	end

	def test_it_generates_random_ships
		puts @ship_1x2.random_1x2
		puts @ship_1x3.random_1x3
	end
end