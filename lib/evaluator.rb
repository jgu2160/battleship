require 'byebug'
class Evaluator
	attr_accessor :ship
	attr_reader :hits_record, :misses_record, :guess_record
	
	def initialize(ship = nil)
		@ship = ship
		@hits_record = []
		@misses_record = []
		@guess_record = []
	end

	def hit(user_coordinate)
		@guess_record << user_coordinate
		@ship.coordinates.each do |x|
			if user_coordinate == x
				@hits_record << x
				@ship.hits += 1
				@ship.coordinates.delete(x)
			else
				@misses_record << user_coordinate
			end
		end

		#janky alert. for some reason, the push on to user_coordinate would happen
		# twice...
		@misses_record.uniq!

		if @ship.size == @ship.hits
			@ship.sunk = true
		end
		@hits_record
	end
end