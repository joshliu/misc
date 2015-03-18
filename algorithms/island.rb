require 'pry'

def start(array,n)
	count = 0
	array.each_with_index do |x,i|
		x.each_with_index do |y,j|
			if y == 1
				count += 1
				flow(array,i,j,n)
			end
		end
	end
	return count
end

def flow(array,i,j,n)
	return if i < 0 || i >= n
	return if j < 0 || j >= n
	return if array[i][j] == 0

	array[i][j] = 0

	flow(array,i+1,j,n) #down
	flow(array,i-1,j,n) #up
	flow(array,i,j+1,n) #right
	flow(array,i,j-1,n) #left
end

def generate(n)
  array = []
  (0...n).each do |x|
    row = []
    (0...n).each do |y|
      row << Random.rand(2)
    end
    array << row
  end
  array.each do |x|
    x.each do |y|
      print "\#" if y == 1
      print "^" if y == 0
    end
    print "\n"
  end
  return start(array,n)
end

binding.pry
