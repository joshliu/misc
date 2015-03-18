require "pry"

def quick_sort(array)
  return [] if array == []
  pivot = array.shift
  less, greater = [], []
  array.each do |n|
    if n <= pivot
      less << n
    else
      greater << n
    end
  end
  return quick_sort(less) + [pivot] + quick_sort(greater)   
end

binding.pry