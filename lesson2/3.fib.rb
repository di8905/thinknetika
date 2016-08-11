fib = []
fib[0] = 0
fib[1] = 1
(2..100).each do |i|
  fib[i] = fib[i-1] + fib[i-2]
end
puts fib
