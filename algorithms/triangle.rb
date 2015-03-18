require 'pry'

def triangle(n,sum)
	if sum == 1326
		return n
	else
		n += 1
		sum += n
		triangle(n,sum)
	end
end

binding.pry