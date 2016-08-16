require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'

class ControlApp

  def show_actions_prompt
    puts <<~ACT_PROMPT
    Select action:
    1) Create station
    2) Create train
    3) Add wagons to train
    4) Remove wagons from train
    5) Move train to station
    6) List stations and trains
  ACT_PROMPT
  end

  def create_station
    puts "creating station"
  end

  def create_train
  end

end

app = ControlApp.new

loop do
  app.show_actions_prompt
  action = gets.chomp
  app.send(action)
end


#Stations
# spb      = Station.new("Спб")
# moskow   = Station.new("Москва")
# vishera  = Station.new("Малая Вишера")
# luban    = Station.new("Любань")
# novgorod = Station.new("Новгород")
#
#
# route95 = Route.new(spb, moskow)
# route95.add_waypoint!(vishera)
# route95.print
# route95.add_waypoint!(luban)
# route95.print
#
#
# route99 = Route.new(spb, novgorod)
# route99.add_waypoint!(vishera)
# route99.add_waypoint!(luban)
# route99.print
#
# #Thomas tests
# thomas = CargoTrain.new("Thomas")
# thomas.route = route95
# thomas.current_station
# spb.list_trains
# thomas.get_to!(luban)
# thomas.current_station
# luban.list_trains
# spb.list_trains
#
#
# #Sapsan tests
# sapsan = PassengerTrain.new("Sapsan")
# sapsan.route = route99
# sapsan.get_to!(luban)
# sapsan.get_to!(moskow)
# luban.list_trains
# luban.list_trains_of_type(:freight)
#
# puts "Route 99:"
# route99.print
# puts "Route 99:"
# route95.print
