require 'pry'
#brute force takes about 4 seconds
#solves the 24 math game
def twenty_four(a,b,c,d)
	puts "this takes about 3 seconds"
	answer = []
	nums = [a,b,c,d].map { |e| e.to_f.to_s }
	nums = nums.permutation.to_a
	operands = ["+","+","+","-","-","-","/","/","/","*","*","*"].permutation(3).to_a
	nums.each do |num|
		operands.each do |operand|
			[0,2,4].each do |x|
				[3,5,7].each do |y|
					if x > y
						next
					else
						array = [num[0],operand[0],num[1],operand[1],num[2],operand[2],num[3]]
						array.insert(x,"(")
						array.insert(y+1,")")
						string = array.join.to_s
						if eval(string) >= 23.9999 && eval(string) <= 24.0001 #floats suck
							if !answer.include?(string)
								puts string
								answer << string
							end
						end
					end
				end
			end
		end
	end
	if answer.length == 0
		return nil
	else
		return answer
	end
end

# twenty_four(1,2,3,4)

binding.pry
