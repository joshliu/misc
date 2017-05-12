require 'pry'

def parse(str)
  arr = [[]]
  cur = ""
  paren_count = 0
  str.chars.each do |c|
    if c == "("
      arr << []
    elsif c == ")"
      temp = arr.pop()
      arr[-1] << temp
    else
      arr[-1] << c
    end
  end
  return arr
end

binding.pry