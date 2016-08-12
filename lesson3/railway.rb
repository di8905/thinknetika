class Station
  
  def initialize(name)
  	@name = name
  end

  def train_arrive(train)	
  end

  def show_trains	
  end

  def train_departure(train)
  end

end

class Route

	def initialize(start, finish)		
	end

	def add_waypoint(station)
	end

	def delete_waypoint(station)
	end

	def list_waypoints
	end

end

class Train

	def initialize(number, type, wagons_num)
	end

	def accelerate(speed)
	end

	def speed
	end

	def stop
	end

	def railcars_num
	end

	def add_wagon
	end

	def remove_wagon
	end

	def route(route)
	end
	
	def get_to(station)	
	end

	def last_station
	end

	def current_station
	end

	def next_station
	end


end