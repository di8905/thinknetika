require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'control_app.rb'

app = ControlApp.new

# Some content for tests
sap = PassengerTrain.new('Sap-an')
tho = CargoTrain.new('Tho-as')
len = CargoTrain.new('Lenny')
app.send(:trains) << sap << tho << len

spb = Station.new('Spb')
msk = Station.new('Moskow')
vi  = Station.new('Vishera')
app.send(:stations) << msk << vi << spb

pw1 = PassengerWagon.new(10)
pw2 = PassengerWagon.new(20)
cw1 = CargoWagon.new(10)
cw2 = CargoWagon.new(20)

sap.add_wagon(pw1)
sap.add_wagon(pw2)
tho.add_wagon(cw1)
tho.add_wagon(cw2)
sap.move!(msk)
tho.move!(spb)
len.move!(vi)

p sap.valid?
p tho.valid?
sap.instance_variable_set(:@number, "Sapsaan")
p sap.valid?

# Main worker
# loop do
#   app.show_actions_prompt
#   app.send(app.action(gets.chomp))
# end
