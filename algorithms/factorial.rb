require "pry"

def factorial(n)
	product = 1
	(1..n).each { |num| product = num*product }
	puts product
end

def fact(n)
	(1..n).to_a.reduce(&:*)
end

def sum_from_one_to_n(n)
	(1..n).to_a.reduce(&:+)
end


binding.pry