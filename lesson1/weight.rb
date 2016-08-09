#Программа определения идеальности веса
puts "Введите ваше имя"
name = gets.chomp.capitalize
puts "Введите ваш рост"
height = gets.chomp.to_f

if height == 0
  puts "#{name}, вы ввели нулевой рост или не число"
else
  ideal_weight = height - 110
end

if ideal_weight <= 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес #{ideal_weight}"
end
