require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'control_app.rb'

app = ControlApp.new

#Some content for tests
# app.trains << PassengerTrain.new("Sapsan") << CargoTrain.new("Thomas")
# app.stations << Station.new("Москва") << Station.new("Вишера") << Station.new("Спб")

#Main worker
loop do
  app.show_actions_prompt
  choise = gets.chomp
  app.action(choise)
end
