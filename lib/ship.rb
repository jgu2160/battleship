require "byebug"
class Ship
	attr_accessor :coordinates, :hits, :size, :sunk

	def initialize(other_ship = nil)
		@other_ship = other_ship
		@coordinates = ["A1", "A2"]
		@size = @coordinates.length
		@sunk = 0
		@hits = 0
		@sample_array = ["A", "B", "C"]
	end

	def random_1x2
		@coordinates[0] = @sample_array.sample + rand(1..3).to_s
		if rand > 0.5
			@coordinates [1] = @coordinates[0][0] + @coordinates[0][1].next 
		else
			@coordinates [1] = @coordinates[0][0].next + @coordinates[0][1]
		end
		@coordinates
	end

	def random_1x3
		@coordinates[0] = @sample_array[0..1].sample + rand(1..2).to_s
		while @other_ship.coordinates.include?(@coordinates[0])
			@coordinates[0] = @sample_array[0..1].sample + rand(1..2).to_s
		end
		if horz_space_check(@coordinates[0],3)
			@coordinates[0][1] = (@coordinates[0][1].to_i - 3).to_s
			@coordinates[1] = @coordinates[0][0] + @coordinates[0][1].next
			@coordinates[2] = @coordinates[0][0] + @coordinates[1][1].next
		else
			@coordinates[0][1] = (@coordinates[0][1].to_i - 3).to_s
			@coordinates[1] = @coordinates[0][0].next + @coordinates[0][1]
			@coordinates[2] = @coordinates[1][0].next + @coordinates[0][1]
		end
		@coordinates
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
