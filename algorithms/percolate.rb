require 'pry'
#### UnionFind Algorithm Commented Out #####

def start(array,n)
  count = 0
  array[0].each_with_index do |x,j|
    if x == 0
      flow(array,0,j,n)
    end
  end
end

def flow(array,i,j,n)

  return if i < 0 || i >= n
  return if j < 0 || j >= n
  return if array[i][j] == 1

  array[i][j] = 1

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
      print "U" if y == 0
    end
    print "\n"
  end
  return start(array,n)
end

# class QuickUnion
#   @id = Array.new
#   def initialize(n)
#     @id = (0..n).to_a
#   end

#   def array
#     return @id
#   end

#   def root(i)
#     while @id[i] != i
#       i = @id[i]
#     end
#     return i
#   end

#   def connected(p,q)
#     return root(p) == root(q)
#   end

#   def union(p,q)
#     @id[root(p)] = root(q)
#   end
# end

# def generate(n)
#   array = []
#   (0...n).each do |x|
#     row = []
#     (0...n).each do |y|
#       row << Random.rand(2)
#     end
#     array << row
#   end
#   array.each do |x|
#     x.each do |y|
#       print "\#" if y == 1
#       print "U" if y == 0
#     end
#     print "\n"
#   end

#   return percolate?(array,n)
# end

# def percolate?(twod, n)
#   # string = string.split("\n")
#   # twod = string.map { |e| e.split }
#   links = QuickUnion.new((n**2)+1)

#   nums = []
#   setup = 0
#   (0...n).each do |x|
#     row = []
#     (0...n).each do |y|
#       row << setup
#       setup += 1
#     end
#     nums << row
#   end

#   p links.array

#   twod.each_with_index do |x,i|
#     x.each_with_index do |y,j|
#       if y == 0
#         puts "#{nums[i][j]} #{links.root(1)}"
#         if x[j+1] == 0 #right
#           if j != n-1
#             links.union(nums[i][j],nums[i][j+1])
#           end
#         end
#         if x[j-1] == 0 #left
#           if j != 0
#             links.union(nums[i][j-1],nums[i][j])
#           end
#         end
#         if i != n-1
#           if twod[i+1][j] == 0 #up
#             links.union(nums[i+1][j],nums[i][j])
#           end
#         end
#         if i != n-1
#           if twod[i-1][j] == 0 #down
#             links.union(nums[i][j],nums[i-1][j])
#           end
#         end
#       end
#     end
#   end

#   p nums

#   binding.pry

#   nums[0].each do |num|
#     links.union(num,(n**2))
#   end

#   nums[-1].each do |lol|
#     links.union(lol,(n**2)+1)
#   end
#   p links.connected((n**2),(n**2)+1)
#   p links.root(36)
#   p links.root(37)
#   return links.connected((n**2),(n**2)+1)
# end

binding.pry