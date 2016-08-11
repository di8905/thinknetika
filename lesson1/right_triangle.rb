def right_triange? a, b, c
  if a**2 + b**2 == c**2 || a**2 + c**2 == b**2 || b**2 + c**2 == a**2
    true
  else false
  end
end

def isosceles_triange? a, b, c
  if a == b || b == c || c == b
    true
  else false
  end
end

puts "Input side a"
a = gets.chomp.to_f
puts "Input side b"
b = gets.chomp.to_f
puts "Input side c"
c = gets.chomp.to_f

puts "Треугольник прямоугольный" if right_triange? a, b, c
puts "Он еще и равнобедренный"   if isosceles_triange? a, b, c
