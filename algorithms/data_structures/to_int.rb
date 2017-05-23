require 'pry'
#cast strings to integers
def make_int(string)
  array = string.split('').reverse
  int = 0
  array.each_with_index do |c,i|
    multiple = 10**(i)
    value = c.ord-48
    int += value*multiple
  end
  return int
end

binding.pry
