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

  def actions_map(choise)
    case choise.to_i
    when 1
      :create_station
    when 2
      :create_train
    when 3
      :add_wagon_to_train
    when 4
      :remove_wagon_from_train
    when 5
      :move_train_to_station
    when 6
      :list_stations
    when 7
      :list_trains_on_station
    when 8
      :list_all_trains
    else
      :show_actions_prompt
    end
  end

  def list_stations
    self.stations.each {|station| print "#{station.name}\n"}
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
    selected_train.add_wagon(Wagon.new(selected_train.type))
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

  def list_trains_on_station
    selected_station = select_station
    selected_station.list_trains
  end

end
