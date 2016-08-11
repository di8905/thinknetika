def area(base, height)
  base * height * 0.5
end

puts "Введите величину основания треугольника:"
base = gets.chomp.to_f
puts "Введите высоту треугольника"
height = gets.chomp.to_f
puts "Площадь треугольника: #{area(base, height)}"
