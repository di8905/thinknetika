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

  def move!(station) #For moving between stations without routes
    self.current_station.train_departure!(self) if self.current_station
    self.current_station = station
    self.current_station.train_arrive!(self)
  end

  def get_to!(station) #Moves on routes
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

  def remove_wagon
    self.wagons.length > 0 ? remove_wagon! : puts("There is no wagons already.")
  end

  def add_wagon(wagon)  #1) Метод вызывается только внутри класса 2)Не private т.к. вызывается в потомках
    speed == 0 && appropriate_wagon?(wagon) ? self.wagons << wagon : puts("Can's add wagon while moving!")
  end

  def next_station
    self.route.waypoints[location+1].name
  end

  protected

  attr_accessor :wagons

  def location # 1) Метод вызывается только внутри класса 2)Не private т.к. вызывается в потомках
    self.route.waypoints.find_index(current_station)
  end

  def remove_wagon!
    speed == 0 ? self.wagons.pop : puts("Can's add wagon while moving!")
  end

  def appropriate_wagon?(wagon) #Вроде дублирования кода и избежали, но архитектурно мне кажется это менее удачно. У нас предок как будто знает что-то о своих потомках и предоставляет для них методы. Это нормально?
    wagon.type == self.type
  end

end
