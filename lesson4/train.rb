class Train

  attr_accessor :current_station #Вообще ему место в private, но валится ошибка. Вопрос в каментах ниже.

  attr_reader :route, :number

  def initialize(number)
    @number     = number
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

  def add_wagon!
    @speed == 0 ? @wagons_num += 1 : pust("Can't add wagon, we are moving!")
  end

  def remove_wagon!
    @speed == 0 ? @wagons_num -= 1 : puts("Can't remove wagon, we are moving!")
  end

  def route=(route)
    @route = route
    self.current_station = @route.waypoints[0]
    self.current_station.train_arrive!(self)
  end

  def get_to!(station)
    if self.route.waypoints.find_index(station)
      self.current_station.train_departure!(self)
      self.current_station = station
      self.current_station.train_arrive!(self)
    else puts "No route to #{station.name}!"
    end
  end

  def last_station
    self.route.waypoints[location-1].name
  end

  def next_station
    self.route.waypoints[location+1].name
  end
  
  private
  # attr_accessor :current_station_id
  def location
    self.route.waypoints.find_index(current_station)
  end

end
