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
				if ship.coordinates.include?(user_coordinate)
					@map.grid_mark(user_coordinate,"🍣")
					@hits_record << user_coordinate
					ship.hits += 1
					hit_it = true
					if ship.size == ship.hits
						ship.sunk = 1
					end
					break
				else
					@misses_record << user_coordinate
					@map.grid_mark(user_coordinate,"💦")
					@misses_record.uniq!
				end
			end
		end
		hit_it
	end
end