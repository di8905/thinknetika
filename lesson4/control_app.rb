class ControlApp

  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains   = []
  end

  def show_actions_prompt
    print("
    Select action:
    1) Create station
    2) Create train
    3) Add wagons to train
    4) Remove wagons from train
    5) Move train to station
    6) List stations
    7) List trains on selected station
    8) List all trains
    >>".chomp)
  end

  def action(choise)
    case choise.to_i
    when 1
      self.create_station
    when 2
      self.create_train
    when 3
      self.add_wagon_to_train
    when 4
      self.remove_wagon_from_train
    when 5
      self.move_train_to_station
    when 6
      self.list_stations
    when 7
      self.list_trains_on_station
    when 8
      self.list_all_trains
    else
      self.show_actions_prompt
    end
  end

  def list_stations
    self.stations.each_with_index {|station, i| print "#{i+1}) #{station.name}\n"}
  end

  def create_station
    print("Enter station name
    >>")
    name = gets.chomp
    self.stations << Station.new(name)
    puts "Station #{name} created."
  end

  def create_train
    print("Enter train name
    >>")
    num = gets.chomp
    print("Enter train type
    >>")
    type = gets.chomp.to_sym
    case type
    when :passenger
      self.trains << PassengerTrain.new(num)
    when :cargo
      self.trains << CargoTrain.new(num)
    end
    puts "#{type.to_s.capitalize} train created, his number:#{num}"
  end

  def add_wagon_to_train
    selected_train = select_train("add wagons")
    if selected_train.type == :cargo
      selected_train.add_wagon(CargoWagon.new)
    elsif selected_train.type == :passenger
      selected_train.add_wagon(PassengerWagon.new)
    else puts "Appropriate type of wagons not found, sorry..."
    end
    puts "Wagon added, #{selected_train.number} now has #{selected_train.wagons_count} wagons"
  end

  def remove_wagon_from_train
    selected_train = select_train("remove wagons")
    selected_train.remove_wagon
    puts "#{selected_train.number} now has #{selected_train.wagons_count} wagons"
  end

  def move_train_to_station
    selected_train   = select_train("move to station")
    selected_station = select_station
    selected_train.move!(selected_station)
  end

  def list_all_trains
    self.trains.each_with_index {|train, i| puts "#{i+1}) #{train.number}" }
  end

  def list_trains_on_station
    selected_station = select_station
    selected_station.list_trains
  end

  private

  def select_station
    puts "Select station:"
    self.list_stations
    print (">>")
    selection = gets.chomp.to_i
    self.stations[selection-1]
  end

  def select_train(action)
    puts "Select train to #{action}:"
    self.list_all_trains
    print (">>")
    selection = gets.chomp.to_i
    self.trains[selection-1]
  end

end
