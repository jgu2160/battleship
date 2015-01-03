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
		@ship_1x2 = Ship.new
		@ship_1x3 = Ship.new(@ship_1x2)
		@evaluator = Evaluator.new(@ship_1x2)
	end