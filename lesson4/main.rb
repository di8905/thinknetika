require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'


#Stations tests
puts "Creating stations:"
p spb      = Station.new("Спб")
p moskow   = Station.new("Москва")
p vishera  = Station.new("Малая Вишера")
p luban    = Station.new("Любань")
p novgorod = Station.new("Новгород")

#Route tests
puts "\nCreating route 95:"
route95 = Route.new(spb, moskow)
puts "Adding waypoint vishera"
route95.add_waypoint!(vishera)
puts "Printing route:"
route95.print
puts "Adding waypoint luban"
route95.add_waypoint!(luban)
puts "Route 95 stations list:"
route95.print
puts "\nCreatins route 99"
route99 = Route.new(spb, novgorod)
puts "Adding waypoint Vishera"
route99.add_waypoint!(vishera)
puts "Adding waypoint Luban"
route99.add_waypoint!(luban)
puts "Route 99 stations list:"
route99.print

#Train tests
puts "\nCreating freight train Thomas, 3 wagons"
thomas = Train.new("Thomas", :freight, 3)
puts "Adding route 95 for Thomas"
thomas.route = route95
puts "Printing Thomas current station name:"
p thomas.current_station
puts "List trains on station Spb"
spb.list_trains
puts "Thomas goes to Luban:"
thomas.get_to!(luban)
puts "Let's see where is Thomas:"
p thomas.current_station
puts "List of trains on station Luban"
luban.list_trains
puts "list trains on station Spb"
spb.list_trains

puts "\n\nCreating passenger train Sapsan, 10 wagons"
p sapsan = Train.new("Sapsan", :passenger, 10)
puts "Adding route 99 for Sapsan"
sapsan.route = route99
puts "Sapsan current station is #{sapsan.current_station.name}"
puts "Sapsan goes to Luban"
sapsan.get_to!(luban)
puts "Sapsan current station is #{sapsan.current_station.name}"
puts "Lets try sapsan reach Moskow:"
sapsan.get_to!(moskow)
puts "Sapsan current station is #{sapsan.current_station.name}"
puts "Sapsan next station is #{sapsan.next_station}"
puts "Sapsan last station is #{sapsan.last_station}"

puts "\n\nList of trains on Любань"
luban.list_trains
puts "List of freight trains on Любань"
luban.list_trains_of_type(:freight)

puts "Route 99:"
route99.print
puts "Route 99:"
route95.print
