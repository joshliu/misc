require 'pry'

def merge_sort(arr)
	  if arr.length <= 1
		      return arr
		        end

	    left,right = [],[]
	      mid_index = arr.length/2

	        arr[0...mid_index].each { |n| left << n }
		  arr[mid_index..arr.length].each { |n| right << n }

		    left = merge_sort(left)
		      right = merge_sort(right)

		        return merge(left,right)
end

def merge(left,right)
	  result = []

	    while left.length > 0 || right.length > 0
		        if left.length > 0 && right.length > 0
				      if left[0] <= right[0]
					              result << left[0]
						              left.shift
							            else
									            result << right[0]
										            right.shift
											          end
				          elsif left.length > 0
						        result << left[0]
							      left.shift
							          else
									        result << right[0]
										      right.shift
										          end
			  end

	      return result
end

binding.pry
