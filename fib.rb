require 'pry'

#just to test recursion

def fib(a,b)
  c = a + b
  puts c
  if c > 1000
    print c
  else
    fib(b,c)
  end
end


binding.pry
