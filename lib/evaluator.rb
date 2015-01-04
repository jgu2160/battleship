require 'byebug'

class Evaluator
	attr_accessor :ship_array, :map
	attr_reader :hits_record, :misses_record, :guess_record
	
	def initialize(opponent_ship_1 = nil, opponent_ship_2 = nil, map = nil)
		@ship_array = [opponent_ship_1, opponent_ship_2]
		@hits_record = []
		@misses_record = []
		@guess_record = []
		@map = map
	end

	def hit(user_coordinate)
		hit_it = false
		@ship_array.each do |ship|
			if ship
				@guess_record << user_coordinate
				ship.coordinates.each do |x|
					if user_coordinate == x
						@hits_record << x
						ship.hits += 1
						ship.coordinates.delete(x)
						@map.grid_mark(user_coordinate,"🍖")
						hit_it = true
					else
						@misses_record << user_coordinate
					end
				end

				#the hit function goes through the ship coordinate array, so it ends up
				# putting multiple misses for the same miss coordinate, thus the need to uniq!
				# this output
				@misses_record.uniq!

				if ship.size == ship.hits
					ship.sunk = 1
				end
				@hits_record
			end
		end
		hit_it
	end
end