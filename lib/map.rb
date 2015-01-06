require 'byebug'
class Map
	attr_accessor :size, :grid_array

	def initialize(size)
		@size = size
		@grid_array = []
		@num_of_spaces = " 🌊" * @size
		self.grid_create
		self.border_create
	end

	def grid_create
		@grid_array[1] = ". 1"
		(@size - 1).times do |x|
			@grid_array[1] << " " + @grid_array[1][-1].next
		end

		@grid_array[2] = "A" + @num_of_spaces
		3.upto(3 + @size - 1) do |x|
			@grid_array[x] = @grid_array[x-1][0].next + @num_of_spaces
		end
	end

	def border_create
		border_string = ""
		(@size+1).times do |x|
			border_string << "🏄 "
		end
		@grid_array[0] = border_string
		@grid_array[size + 2] = border_string
	end

	def grid_mark(coordinate, marker_type)
		@grid_array.each do |x|
			if coordinate[0] == x[0]
				x[coordinate[1].to_i * 2] = marker_type
			end
		end	
	end
end

# 🚢⛵️⚓🐙🐋🐬💥-○💦🐡🏄
# 🚤🚣🚨🐠🐳🐟🍖🌊🍣🍗🏊

if __FILE__ == $0
	puts ["===========\n", ". 1 2 3 4\n", "A X X\n", "B     Y\n", "C     Y\n", "D     Y\n", "==========="]
end