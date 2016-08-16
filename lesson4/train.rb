class Train

  attr_accessor :current_station

  attr_reader :route, :number

  def initialize(number)
    @number     = number
    @speed      = 0
    @wagons     = []
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

  def wagons_count
    self.wagons.length
  end

  def next_station
    self.route.waypoints[location+1].name
  end

  protected

  attr_accessor :wagons

  def location # 1) Метод вызывается только внутри класса 2)Не private т.к. вызывается в потомках
    self.route.waypoints.find_index(current_station)
  end

  def add_wagon!(wagon)  #1) Метод вызывается только внутри класса 2)Не private т.к. вызывается в потомках
    speed == 0 ? self.wagons << wagon : puts("Can's add wagon while moving!")
  end

end
