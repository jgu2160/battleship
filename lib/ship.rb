require "byebug"
class Ship
	attr_accessor :coordinates, :hits, :size, :sunk, :board_size

	def initialize(other_ship_array = nil, board_size = 4)
		@other_ship_array = other_ship_array 
		@coordinates = ["A1", "A2"]
		@size = @coordinates.length
		@sunk = 0
		@hits = 0
    @board_size = board_size
    @sample_array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"][0..(@board_size - 1)]
	end

	def random_1x2
    @coordinates[0] = @sample_array.sample + rand(1..@board_size).to_s
    while @coordinates[0] == ((@sample_array[-1] + (@board_size - 1).to_s) || (@sample_array[-2] + (@board_size).to_s) || (@sample_array[-1] + @board_size.to_s))
    	@coordinates[0] = @sample_array.sample + rand(1..@board_size).to_s
    end

    if self.on_bottom_edge?(@coordinates[0],2)
			@coordinates [1] = @coordinates[0][0] + @coordinates[0][1].next 
		else
			@coordinates [1] = @coordinates[0][0].next + @coordinates[0][1]
		end
		@coordinates
	end

	# def random_1x3
	# 	@coordinates[0] = @sample_array[0..1].sample + rand(1..2).to_s
	# 	while @other_ship.coordinates.include?(@coordinates[0])
	# 		@coordinates[0] = @sample_array[0..1].sample + rand(1..2).to_s
	# 	end
	# 	if horz_space_check(@coordinates[0],3)
	# 		@coordinates[0][1] = (@coordinates[0][1].to_i - 3).to_s
	# 		@coordinates[1] = @coordinates[0][0] + @coordinates[0][1].next
	# 		@coordinates[2] = @coordinates[0][0] + @coordinates[1][1].next
	# 	else
	# 		@coordinates[0][1] = (@coordinates[0][1].to_i - 3).to_s
	# 		@coordinates[1] = @coordinates[0][0].next + @coordinates[0][1]
	# 		@coordinates[2] = @coordinates[1][0].next + @coordinates[0][1]
	# 	end
	# 	@coordinates
	# end

  def random_1xSize(size)
    @coordinates[0] = @sample_array.sample + rand(1..@board_size).to_s
		while @other_ship_array.flatten.include?(@coordinates[0]) && in_corner?(@coordinates[0], size)
			@coordinates[0] = @sample_array[0..1].sample + rand(1..2).to_s
		end
  end

  def linear_placer(coordinate, vert_hor)
    new_coordinate = nil
    if vert_hor == "v"
      new_coordinate = coordinate[0].next + coordinate[1]
    else
      new_coordinate = coordinate[0] + coordinate[1].next
    end
    new_coordinate
  end

  def in_corner?(coordinate, ship_size)
    the_corner = []
    the_corner << (@sample_array[ - (ship_size-1)] + (@board_size - (ship_size - 2)).to_s)
    
    0.upto(ship_size - 3) do |x|      
     the_corner << linear_placer(the_corner[x], "v")
    end

    array_length = the_corner.length
    if array_length == 2
     0.upto(1) do |x|      
     the_corner << linear_placer(the_corner[x], "h")
    end
    else
     0.upto(array_length * (array_length - 2)) do |x|      
      the_corner << linear_placer(the_corner[x], "h")
     end
    end
    return the_corner.include?(coordinate)
  end

  def on_bottom_edge?(coordinate, ship_size)
    @sample_array[-(ship_size - 1)..-1].include?(coordinate[0])
  end

  def on_right_edge?(coordinate, ship_size)
    ((@board_size - ship_size + 2)..@board_size).to_a.include?(coordinate[1].to_i)
  end
  
  def straight?(array)
    array.sort!
	  straight_count = 0
    1.upto(array.length-1) do |x|
      if array[x-1][0].next + array[x-1][1] == array[x]
        straight_count += 1
      elsif array[x-1][0] + array[x-1][1].next == array[x]
        straight_count += 1
      end
    end
    true if straight_count == array.length - 1
	end

  def blocked?(array)
    blocked = false
    array.each do |coordinate|
      if @other_ship_array.flatten.include?(coordinate)
        blocked = true
        break
      end
    end
    blocked
  end

	def horz_space_check(starting_coordinate, ship_size)
		space_okay = true
		ship_size.times do |x|
			if @other_ship.coordinates.include?(starting_coordinate)
				space_okay = false
			end
			starting_coordinate[1] = starting_coordinate[1].next
		end
		return space_okay
	end
end
