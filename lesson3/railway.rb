class Station

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
  	@trains.each {|train| freight? freight_train_count += 1 : passenger_train_count += 1 }
  	puts passenger_train_count
  	puts freight_train_count
  end

  def train_departure!(train)
  	@trains.delete(train)
  end

end

class Route

  def initialize(start, finish)
  	@waypoints << start << finish
  end

  def add_waypoint!(station)
  	@waypoints.insert(-2, station)
  end

  def delete_waypoint!(station)
  	@waypoints.delete(station)
  end

  def list_waypoints
  	p @waypoints
  end

end

class Train

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

	def railcars_num
    @wagons_num
	end

	def add_wagon!
    @speed = 0 ? @wagons_num += 1 : puts "Can't add wagon, we are moving!"
	end

	def remove_wagon!
    @speed = 0 ? @wagons_num -= 1 : puts "Can't remove wagon, we are moving!"
	end

	def route!(route)
    @route = route
    get_to! = route[0]
	end

	def get_to!(station)
    
	end

	def last_station
	end

	def current_station

	end

	def next_station
	end

  def freight?
  end

end
