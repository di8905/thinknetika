class Station

attr_accessor :name, :trains

  def initialize(name)
  	@name = name
    @trains = []
  end

  def train_arrive!(train)
    @trains << train
  end

  def list_trains
    p @trains #TODO make me better!
  end

  def trains_number_by_type
  	passenger_train_count = 0
  	freight_train_count   = 0
  	@trains.each {|train| freight? ? freight_train_count += 1 : passenger_train_count += 1 }
  	puts passenger_train_count
  	puts freight_train_count
  end

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
  	@waypoints.map {|point| puts "Station #{point.name}: #{point.trains}"}
  end

end

class Train

attr_reader :route

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

	def route!(route) #Не пойму, стоит ли этот метод называть с восклицательным знаком?
    @route = route
    self.current_station_id = 0
	end

  def get_to!(station)
    puts self.route.inspect
		self.current_station_id = route.waypoints.find_index { |waypoint| waypoint.name == station }
	end

	def current_station
		self.route.waypoints[@current_station_id].name
	end

	def last_station
		route(current_station_id-1)
	end

	def next_station
		route(current_station_id+1)
	end

	def freight?
		type == :freight
	end

  private
  attr_accessor :current_station_id
  # attr_reader   :route #В private т.к. в ТЗ не было задачи реализовать метод демонстрации маршрута

end

#Stations tests
puts "Creating stations:"
p spb     = Station.new("Спб")
p moskow  = Station.new("Москва")
p vishera = Station.new("Малая Вишера")
p luban   = Station.new("Любань")

#Route tests
puts "\nCreating route 95:"
p route95 = Route.new(spb, moskow)
puts "Adding waypoint vishera"
p route95.add_waypoint!(vishera)
puts "Printing route:"
route95.print
puts "Adding waypoint luban"
p route95.add_waypoint!(luban)
route95.print

#Train tests
puts "\nCreating freight train Thomas, 3 wagons"
p thomas = Train.new("Thomas", :freight, 3)
puts "Creating passenger train Sapsan, 10 wagons"
p sapsan = Train.new("Sapsan", :passenger, 10)
puts "Adding route for Thomas"
thomas.route!(route95)
puts "Printing Thomas current station name:"
p thomas.current_station
puts "Thomas goes to Luban"
thomas.get_to!("Любань")
puts "Let's see where is Thomas:"
p thomas.current_station
