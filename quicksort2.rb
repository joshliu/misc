def quicksort(array)
  return [] if array == []
  pivotal = array.shift;
  less, greater = [], []
  array.each do |x|
    if x <= pivotal 
      less << x
    else 
      greater << x
    end
  end
  return quicksort(less) + [pivotal] + quicksort(greater)
end