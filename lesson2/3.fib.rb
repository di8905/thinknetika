fib = []
fib[0] = 0
fib[1] = 1
(2..100).each do |i|
  fib[i] = fib[-1] + fib[-2]
end
puts fib
