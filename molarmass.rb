require 'pry'
require 'active_record'

class String
  def is_upper?
    self == self.upcase && self != self.downcase
  end

  def is_lower?
    self == self.downcase && self != self.upcase
  end

  def is_element?
  	if Element.find_by_symbol(self) != nil
  		return true
  	else
  		return false
  	end
  end

  def element
  	Element.find_by_symbol(self)
  end
end

class Array
	def contains_only(some_class)
		contains = true
		self.each do |x|
			if x.class == some_class
				next
			else
				contains = false
			end
		end
		return contains
	end

	def format
		self.each_with_index do |x,i|
			if x.class == Fixnum
				if self[i-1] != ")"
					self[i-1] = self[i-1]*x
					self.delete_at(i)
				else
					next
				end
			elsif x == "("
				self.each_with_index do |x2,i2|
					if x2 == ")"
						m = self[i+1...i2].format
						self.insert(i,m)
						(i2+1-i).times {self.delete_at(i+1)}
						return self
					end
				end
			end
		end
		if self.contains_only(Float)
			return self.reduce(:+)
		else
			self.format
		end
	end

end

class Element < ActiveRecord::Base
	establish_connection(adapter:'mysql2',
		database:'elements'
	)
end

def molar_mass(compound)

	formatted = []

	compound = compound.split("")

	compound.each_with_index do |x,i|
		if x.is_lower?
			next
		elsif x.is_upper?
			if compound[i+1] != nil
				if compound[i+1].is_lower?
					formatted << compound[i..i+1].join
				else
					formatted << x
				end
			end
		elsif x.to_i > 0 || x == "0"
			if compound[i+1].to_i > 0 || compound[i+1] == "0"
				formatted << compound[i..i+1].join.to_i
				compound.delete_at(i+1)
			else
				formatted << x.to_i
			end
		else
			formatted << x
		end
	end

	formatted.each_with_index do |x,i|
		if x.class == String
			if x.is_element?
				formatted[i] = x.element.mass
			end
		end
	end

	until formatted.contains_only(Float)
		formatted.flatten!
		formatted.format
	end

	return formatted.reduce(:+).round(3)


end


binding.pry