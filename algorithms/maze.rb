class Cell
	attr_accessor :north, :south, :east, :west, :coordinate
	def initialize(coordinate)
		@north = 1
		@south = 1
		@east = 1
		@west = 1
		@coordinate = coordinate
	end
	def left
		[coordinate.first-1,coordinate.last]
	end
	def right
		[coordinate.first+1,coordinate.last]
	end
	def below
		[coordinate.first,coordinate.last+1]
	end
	def above
		[coordinate.first,coordinate.last-1]
	end
end

class Maze
	attr_reader :count, :x_length, :y_length
	attr_accessor :maze

	def initialize(x,y)
		@x_length = x
		@y_length = y
		@count = x*y
		@maze = []

		(0...y).each do |i|
			row = []
			(0...x).each do |j|
				row << Cell.new([j,i])
			end
			maze << row
		end
	end

	def get_options(coordinate,visited)
		options = []
		x = coordinate.first
		y = coordinate.last
		left = [x-1,y]
		right = [x+1,y]
		above = [x,y-1]
		below = [x,y+1]

		options << left if (x-1 >= 0) && !visited.include?(left)
		options << right if (x+1 < x_length) && !visited.include?(right)
		options << above if (y-1 >= 0) && !visited.include?(above)
		options << below if (y+1 < y_length) && !visited.include?(below)
		return options
	end

	def join(coordinate1, coordinate2)
    cell1 = maze[coordinate1.last][coordinate1.first]
    cell2 = maze[coordinate2.last][coordinate2.first]

    if cell1.coordinate == cell2.left
      cell1.east = 0
      cell2.west = 0
    end

    if cell1.coordinate == cell2.right
      cell1.west = 0
      cell2.east = 0
    end

    if cell1.coordinate == cell2.above
      cell1.south = 0
      cell2.north = 0
    end

    if cell1.coordinate == cell2.below
      cell1.north = 0
      cell2.south = 0
    end
  end

	def create_maze
		current = [rand(x_length),rand(y_length)]
		visited,cell_stack = [],[]

		visited << current
		cell_stack << current

		while visited.length < count
			print_maze(cell_stack.last)
			sleep(0.05)
			choices = get_options(cell_stack.last,visited)
			if choices.length > 0
				choice = choices.sample
				join(choice, cell_stack.last)
				visited << choice
				cell_stack << choice
			else
				cell_stack.pop
			end
		end
	end

	def print_maze(coordinate)

    string = "+"

    string << "---+" * maze.first.size
    string << "\n"

    maze.each_with_index do |row,i|

      vertical_walls = ""

      bottom_walls = "+"

      row.each_with_index do |cell,j|

        vertical_walls << "|" if cell.west == 1
        vertical_walls << " " if cell.west == 0
        vertical_walls << "   " if [j,i] != coordinate
        vertical_walls << "wat" if [j,i] == coordinate
        bottom_walls << "---+" if cell.south == 1
        bottom_walls << "   +" if cell.south == 0

      end

      vertical_walls << "|\n" if row.last.east == 1
      vertical_walls << " \n" if row.last.east == 0
      bottom_walls << "\n"

      string << vertical_walls
      string << bottom_walls

    end

    puts(string)
  end

end

puts "What is the horizontal size of the maze you want to generate? (Enter a positive integer):"
x_size = gets.chomp.to_i
puts "What is the Vertical size of the maze you want to generate? (Enter a positive integer):"
y_size = gets.chomp.to_i

m = Maze.new(x_size, y_size)
m.create_maze
m.print_maze([-1,-1])