require 'pry'

def prime_factorization(n)
	factors = []

	(2..n*0.5).each do |x|
		while n % x == 0
			factors << x
			 n = n/x
		end
	end
	return factors
end


binding.pry
