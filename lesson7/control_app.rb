class ControlApp

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
    8) Trains with wagons by station
    >>".chomp)
  end

  def action(choise)
    case choise.to_i
    when 1
      create_station
    when 2
      create_train
    when 3
      add_wagon_to_train
    when 4
      remove_wagon_from_train
    when 5
      move_train_to_station
    when 6
      list_stations
    when 7
      list_trains_on_station
    when 8
      train_with_wagons_by_station
    else
      show_actions_prompt
    end
  end

  private

  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains   = []
  end

  def list_stations
    stations.each_with_index {|station, i| print "#{i+1}) #{station.name}\n"}
  end

  def create_station
    print("Enter station name
    >>")
    name = gets.chomp
    stations << Station.new(name)
    puts "Station #{name} created."
  end

  def create_train
    print("Enter train number in xxx-xx or xxxxx format
    >>")
    num = gets.chomp
    print("Enter train type - cargo or passenger allowed
    >>")
    type = gets.chomp.to_sym
    case type
    when :passenger
      trains << PassengerTrain.new(num)
    when :cargo
      trains << CargoTrain.new(num)
    else raise "Wrong train type!"
    end
    puts "#{type.capitalize} train created, his number: #{num}"
  rescue StandardError => e
    puts e
    retry
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

  def train_with_wagons_by_station
    stations.each do |station|
      puts "#{station.name}:"
        station.each_train do |train|
          puts "  Train number: #{train.number}, Type: #{train.type}, #{train.wagons_count} wagons:"
          train.each_wagon do |wagon|
            puts "    Wagon serial: #{wagon.serial}, space available #{wagon.space_avail}"
          end
        end
    end

  end

  def list_trains_on_station
    selected_station = select_station
    selected_station.list_trains
  end

  def select_station
    puts "Select station:"
    list_stations
    print (">>")
    selection = gets.chomp.to_i
    stations[selection-1]
  end

  def select_train(action)
    puts "Select train to #{action}:"
    list_all_trains
    print (">>")
    selection = gets.chomp.to_i
    trains[selection-1]
  end

end
