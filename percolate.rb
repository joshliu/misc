require 'pry'

class QuickUnion
  @@id = Array.new
  def initialize(n)
    @@id = (0..n).to_a
  end

  def root(i)
    while @@id[i] != i
      i = @@id[i]
    end
    return i
  end

  def connected(p,q)
    return root(p) == root(q)
  end

  def union(p,q)
    @@id[root(p)] = root(q)
  end
end

binding.pry
