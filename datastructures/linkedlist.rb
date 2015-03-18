require 'pry'

class Node
	attr_accessor :value, :next, :previous
  def initialize(value)
  	@value = value
  end

  def append(node)
  	if node.class == Fixnum
  		node = Node.new(node)
  	end
  	node.previous = self.last()
  	self.last().next = node
  end

  def last()
  	return self if self.next == nil
  	node = self.next.last()
  end

  def first()
  	return self if self.previous == nil
  	node = self.previous.first()
  end

  def to_s()
  	return self.value.to_s
  end

  def at_index(int)
  	node = self.first()
  	i = 0
  	while i < int-1
  		node = node.next
  		i += 1
  	end
  	return node
  end

  def list()
  	start = self.first()
  	array = []
  	while start.next != nil
  		array << start.value
  		start = start.next
  	end
  	return array
  end

  def delete()
  	if node.first == node
  		if node.next == nil
  			return
  		end
  		node.next.previous = nil
  		return
  	end
  	if node.last == node
  		node.previous.next = nil
  		return
  	end
  	node.next.previous = node.previous
  	node.previous.next = node.next
  end


end

binding.pry
