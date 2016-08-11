MONTHS = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def leap?(year)
  (year % 400).zero? || year == 2000 || ( (year % 4).zero? && !(year % 100).zero? )
end

def month_days_summator(month)
  MONTHS[0..month].inject {|sum, days_count| sum + days_count}
end

def correct_date?(day, month, year)
  leap?(year) && month == 2 ?  day < MONTHS[month] : day <= 28
end

def date_number(day, month, year)
  if month < 2
    day
  elsif month == 2
    day + month_days_summator(month-2)
  else
    leap?(year) ? day + month_days_summator(month-2) : day - 1 + month_days_summator(month-2)
  end

end

loop do
puts "Enter date in dd.mm.yyyy format:"
date = gets.chomp.split(".")
day   = date[0].to_i
month = date[1].to_i
year  = date[2].to_i
unless correct_date?(day, month, year)
  puts "Please enter correct date"
else
  puts date_number(day, month, year)
end
end
