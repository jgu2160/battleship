require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class EvaluatorTest < MiniTest::Test
	def setup
		@ship_1x2 = Ship.new
		@ship_1x3 = Ship.new(@ship_1x2)
		@evaluator = Evaluator.new(@ship_1x2)
		@map = Map.new(4)
		@evaluator.map = @map
	end

	def test_it_exists
		assert @evaluator
	end

	def test_it_registers_a_hit
		@evaluator.hit("A1")
		assert_equal 1, @ship_1x2.hits
		@evaluator.hit("A3")
		assert_equal 1, @ship_1x2.hits
	end

	def test_it_hits_on_a_hit
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal 2, @ship_1x2.hits
	end

	def test_it_sinks_a_1x2
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal 1, @ship_1x2.sunk
	end

	def test_it_sinks_a_1x3
		@ship_1x3.random_1x3
		@evaluator.ship_array[1] = @ship_1x3
		@ship_1x3.coordinates[0] = "B1"
		@ship_1x3.coordinates[1] = "B2"
		@ship_1x3.coordinates[2] = "B3"
		@evaluator.hit("B1")
		@evaluator.hit("B2")
		@evaluator.hit("B3")
		assert_equal 1, @ship_1x3.sunk
	end

	def test_it_deletes_old_ship_entries
		@evaluator.hit("A1")
		@evaluator.hit("A1")
		assert_equal 1, @ship_1x2.hits
	end

	def test_it_ouputs_the_hit_entries
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		assert_equal ["A1", "A2"], @evaluator.hits_record
	end

	def test_it_ouputs_the_miss_entries
		miss_evaluator = Evaluator.new(Ship.new)
		miss_evaluator.hit("A3")
		miss_evaluator.hit("A4")
		assert_equal ["A3", "A4"], miss_evaluator.misses_record
	end

	def test_it_shows_hit_coordinates
		@ship_1x3.random_1x3
		@evaluator.ship_array[1] = @ship_1x3
		@ship_1x3.coordinates[0] = "B1"
		@ship_1x3.coordinates[1] = "B2"
		@ship_1x3.coordinates[2] = "B3"
		@ship_1x2.coordinates.each do |coordinate|
			@map.grid_mark(coordinate, "🐬")
		end
		@ship_1x3.coordinates.each do |coordinate|
			@map.grid_mark(coordinate, "🐋")
		end
		@evaluator.hit("A1")
		@evaluator.hit("B2")
		puts @map.grid_array

	end 

	def test_it_sinks_both_ships
		@ship_1x2.random_1x2
		@ship_1x3.random_1x3
		@evaluator.ship_array[0] = @ship_1x2
		@evaluator.ship_array[1] = @ship_1x3
		@ship_1x2.coordinates[0] = "A1"
		@ship_1x2.coordinates[1] = "A2"
		@ship_1x3.coordinates[0] = "B1"
		@ship_1x3.coordinates[1] = "B2"
		@ship_1x3.coordinates[2] = "B3"
		@evaluator.hit("A1")
		@evaluator.hit("A2")
		@evaluator.hit("B1")
		@evaluator.hit("B2")
		@evaluator.hit("B3")
		assert_equal 1, @ship_1x3.sunk
		assert_equal 1, @ship_1x2.sunk
	end
end