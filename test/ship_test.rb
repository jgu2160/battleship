require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/evaluator'
require './lib/printer'
require './lib/map'

class ShipTest < MiniTest::Test
	def setup
		@ship_1x2 = Ship.new
    @ship_1x2.coordinates = ["A1", "A2"]
		@ship_1x3 = Ship.new(@ship_1x2.coordinates)
    @ship_1x3.random_1xSize(3)
	end

	# def test_it_generates_a_predictable_1x2_ship
	# 	assert_equal ["A1", "A2"], @ship_1x2.coordinates
	# end

	# def test_it_generates_a_random_1x2_ship
	# 	random_1x2 = Ship.new(nil, 10)
	# 	puts random_1x2.random_1x2
	# end

	# def test_it_generates_a_1x3_not_on_top_of_the_1x2
	# 	puts @ship_1x3.random_1x3
	# end

	# def test_space_check_checks_spaces_of_existing_ships_given_a_size
	# 	refute @ship_1x3.horz_space_check("A1",3)
	# 	assert @ship_1x3.horz_space_check("B1",3)
	# end

	# def test_it_generates_random_ships
	# 	puts @ship_1x2.random_1x2
	# 	puts @ship_1x3.random_1x3
	# end

  # def test_it_straights
  #   assert @ship_1x2.straight?(["A1","A2"]) 
  #   assert @ship_1x2.straight?(["A1","B1"]) 
  #   refute @ship_1x2.straight?(["A1","B2"])
  # end

  # # def test_it_blocks
  # #   refute @ship_1x3.blocked?(["B2","B3","B4"])
  # #   assert @ship_1x3.blocked?(["A1","A2","A3"])
  # #   assert @ship_1x3.blocked?(["A2","B2","C2"])
  # # end

  # def test_it_places_linearly_or_vertically
  #    assert_equal "B2", @ship_1x3.linear_placer("A2","v")
  #    assert_equal "A3", @ship_1x3.linear_placer("A2","h")
  # end

  # def test_is_the_given_ship_cornered
  #   assert @ship_1x3.in_corner?("C3", 3)
  #   refute @ship_1x3.in_corner?("C2", 3)
  #   assert @ship_1x3.in_corner?("C4", 3)
  #   assert @ship_1x3.in_corner?("D4", 3)
  #   another_ship = Ship.new(nil, 5)
  #   assert another_ship.in_corner?("E3", 4)
  #   assert another_ship.in_corner?("C3", 4)
  #   refute another_ship.in_corner?("C2", 4)
  #   assert another_ship.in_corner?("D4", 4)
  #   assert another_ship.in_corner?("E5", 4)
  # end

  # def test_it_knows_bottom_and_top_edges
  #   new_ship = Ship.new(nil, 4)
  #   assert new_ship.on_bottom_edge?("C2", 3)
  #   refute new_ship.on_bottom_edge?("B2", 3)
  #   assert new_ship.on_right_edge?("C3",3)
  #   refute new_ship.on_right_edge?("C2",3)
  #   new_ship_2 = Ship.new(nil, 6)
  #   assert new_ship_2.on_bottom_edge?("C2", 5)
  #   refute new_ship_2.on_bottom_edge?("B2", 5)
  #   assert new_ship_2.on_right_edge?("C3", 5)
  #   refute new_ship_2.on_right_edge?("C2", 5)
  # end

  # def test_it_generates_random_coordinate_according_to_size
  #   @ship_1x2.coordinates = ["A1", "A2"]
  #   new_ship = Ship.new(@ship_1x2.coordinates, 4)
  #   puts new_ship.random_1xSize(3)
  # end

  def test_it_generates_a_1x4_on_a_5x5_grid
    ship_1x2 = Ship.new(nil, 9)
    ship_1x2.random_1x2
    ship_1x3 = Ship.new(ship_1x2.coordinates, 9)
    ship_1x3.random_1xSize(3)
    ship_1x4 = Ship.new(ship_1x2.coordinates + ship_1x3.coordinates, 9)
    ship_1x4.random_1xSize(4)

    puts ship_1x2.coordinates + ship_1x3.coordinates + ship_1x4.coordinates
  end

end
