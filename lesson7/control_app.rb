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
    9) List wagons
   10) Load wagon
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
      trains_with_wagons
    when 8
      trains_by_station
    when 9
      list_wagons
    when 10
      load_wagon
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
    print "Please enter wagon capacity >>"
    capacity = gets.chomp.to_f
    if selected_train.type == :cargo
      selected_train.add_wagon(CargoWagon.new(capacity))
    elsif selected_train.type == :passenger
      selected_train.add_wagon(PassengerWagon.new(capacity.to_i))
    else puts "Appropriate type of wagons not found, sorry..."
    end
    puts "Wagon added, #{selected_train.number} now has #{selected_train.wagons_count} wagons"
  end

  def remove_wagon_from_train
    selected_train = select_train("remove wagons")
    selected_train.remove_wagon
    puts "#{selected_train.number} now has #{selected_train.wagons_count} wagons"
  end

  def list_wagons(selected_train = nil)
    selected_train ||= select_train("list wagons")
    i = 0
    selected_train.each_wagon do |wagon|
      i = i + 1
      puts "    #{i}) Wagon serial: #{wagon.serial}, type: #{wagon.type},  space available #{wagon.space_avail}"
    end
  end

  def move_train_to_station
    selected_train   = select_train("move to station")
    selected_station = select_station
    selected_train.move!(selected_station)
  end

  def trains_with_wagons(station = nil)
    station ||= select_station
    station.each_train do |train|
      puts "  Train number: #{train.number}, Type: #{train.type}, #{train.wagons_count} wagons:"
      list_wagons(train)
    end
  end

  def trains_by_station
    stations.each_with_index do |station|
      puts station.name
      trains_with_wagons(station)
    end
  end

  def load_wagon(selected_train = nil, selected_wagon = nil)
    selected_train ||= select_train("to load wagon")
    selected_wagon ||= select_wagon(selected_train)
    if selected_wagon.type == :passenger
      selected_wagon.take_seat
      "Passenger wagon selected, one seat occupied"
    elsif selected_wagon.type == :cargo
      puts "Cargo wagon selected, enter amount to load:"
      amount = gets.chomp.to_f
      selected_wagon.load!(amount)
    end
  rescue NoMethodError  
  end

  def list_all_trains #Helper for select train
    trains.each_with_index do |train, i|
      puts "#{i+1}) #{train.number}"
    end
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

  def select_wagon(train = nil)
    list_wagons(train)
    print "select wagon to load >> "
    wagon = gets.chomp.to_i - 1
    train.wagons[wagon]
  end

end
