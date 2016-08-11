puts "Input A"
a = gets.chomp.to_f
puts "Input B"
b = gets.chomp.to_f
puts "Input C"
c = gets.chomp.to_f

def discriminant a, b, c
  b**2 - 4 * a * c
end

def equation_roots a, b, c
  d = discriminant a, b, c
  if d < 0
    puts "This equation have no roots"
  elsif d == 0
    puts "The equation have one root x = #{-b/(2*a)}"
  else
    puts "The equation have following roots x1 = #{(-b + Math.sqrt(d))/2*a}, x2 = #{(-b - Math.sqrt(d))/2*a} "
  end
end

equation_roots a, b, c
