class List

  def initialize
    @items = {}
  end

  def add(name)
    puts "Enter price:"
    price = gets.chomp.to_f.round(2)
    puts "Enter quantity:"
    quantity = gets.chomp.to_f.round(2)
    @items[name] = {price: price, quantity: quantity}
  end

  def print
    @items.each_pair {|name, attr| puts "#{name}: #{attr[:price]}$ #{attr[:quantity]} pcs, total position price #{attr[:price] * attr[:quantity]}$"}
  end

  def sum
    sum = 0
    @items.each_value {|item| sum += item[:price] * item[:quantity]}
    sum
  end

end

list = List.new
loop do
  puts "Enter purchase name"
  name = gets.chomp.to_sym
  break if name == :stop
  list.add(name)
  list.print
  puts "Total list sum #{list.sum}"
end
