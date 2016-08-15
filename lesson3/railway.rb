class Station

attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrive!(train)
    @trains << train
  end

  def list_trains #Это метод для всех поездов на станции
    self.trains.each_with_index {|train, i| puts "#{i+1}) #{train.number}, #{train.type}, #{train.wagons_num} wagons"}
  end

  def list_trains_of_type(type)
    count = 0
    @trains.each do |train|
      if train.type == type
        puts train.number
        count += 1
      end
    end
    puts "There is #{count} #{type} trains on the station #{self.name}"
  end

  # def trains_number_by_type
  #   passenger_train_count = 0
  #   freight_train_count   = 0
  #   @trains.each {|train| train.freight? ? freight_train_count += 1 : passenger_train_count += 1 }
  #   puts "There is #{passenger_train_count} passenger train(s) on #{self.name}"
  #   puts "There is #{freight_train_count} freight train(s) on #{self.name}"
  # end

  def train_departure!(train)
    @trains.delete(train)
  end

end

class Route

  attr_reader :waypoints

  def initialize(start, finish)
    @waypoints = []
    @waypoints << start << finish
  end

  def add_waypoint!(station)
  	@waypoints.insert(-2, station)
  end

  def delete_waypoint!(station)
  	@waypoints.delete(station)
  end

  def print
  	@waypoints.map {|point| puts "Station #{point.name}\n"}
  end

end

class Train

  attr_accessor :current_station_id #Вообще ему место в private, но валится ошибка. Вопрос в каментах ниже.

  attr_reader :route, :number, :type, :wagons_num

	def initialize(number, type, wagons_num)
    @number     = number
    @type       = type
    @wagons_num = wagons_num
    @speed      = 0
	end

	def accelerate!(speed)
    @speed = speed
	end

	def speed
    @speed
	end

	def stop!
    @speed = 0
	end

	def wagons_num
    @wagons_num
	end

	def add_wagon!
    @speed == 0 ? @wagons_num += 1 : pust("Can't add wagon, we are moving!")
	end

	def remove_wagon!
    @speed == 0 ? @wagons_num -= 1 : puts("Can't remove wagon, we are moving!")
	end

	def route!(route) #Не пойму, стоит ли этот метод называть с восклицательным знаком? С методами просто меняющими атрибуты это очевидно, но здесь происходит гораздо больше.
    @route = route
    self.current_station_id = 0
    get_to!(@route.waypoints[0].name) #Странно. Если current_station_id делаю private, в этом месте выдает ошибку, типа вызван private метод. Но это же нормально, мы внутри объекта. Почему я не могу тут вызвать private метод?
	end

  def get_to!(station)
    dest_station_id = route.waypoints.find_index { |waypoint| waypoint.name == station }
    if dest_station_id
      route.waypoints[current_station_id].train_departure!(self)
      route.waypoints[dest_station_id].train_arrive!(self)
      self.current_station_id = dest_station_id
    else
      puts("There is no #{station} in my route, can't get there.")
    end
  end

	def current_station
		self.route.waypoints[@current_station_id].name
	end

	def last_station
		self.route.waypoints[@current_station_id-1].name
	end

	def next_station
		self.route.waypoints[@current_station_id+1].name
	end

  def freight?
		type == :freight
	end

  private
  # attr_accessor :current_station_id

end

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
thomas.route!(route95)
puts "Printing Thomas current station name:"
p thomas.current_station
puts "List trains on station Spb"
spb.list_trains
puts "Thomas goes to Luban:"
thomas.get_to!("Любань")
puts "Let's see where is Thomas:"
p thomas.current_station
puts "List of trains on station Luban"
luban.list_trains
puts "list trains on station Spb"
spb.list_trains

puts "\n\nCreating passenger train Sapsan, 10 wagons"
p sapsan = Train.new("Sapsan", :passenger, 10)
puts "Adding route 99 for Sapsan"
sapsan.route!(route99)
puts "Sapsan current station is #{sapsan.current_station}"
puts "Sapsan goes to Luban"
sapsan.get_to!("Любань")
puts "Sapsan current station is #{sapsan.current_station}"
puts "Lets try sapsan reach Moskow:"
sapsan.get_to!("Москва")
puts "Sapsan current station is #{sapsan.current_station}"
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
