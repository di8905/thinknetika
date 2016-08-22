require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  include Manufacturer
  include InstanceCounter
  include Validation

  attr_accessor :current_station
  attr_reader :route, :number

  @@trains = {}

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number)
    @number       = number
    validate!(number, NUMBER_FORMAT)
    @speed        = 0
    @wagons       = []
    @@trains     << self
    register_instance
  end

  def valid?
    validate!(self.number, NUMBER_FORMAT)
  rescue
    false
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
    end
  end

  def last_station
    self.route.waypoints[location-1].name
  end

  def wagons_count
    self.wagons.length
  end

  def remove_wagon
    remove_wagon! if self.wagons.length > 0
  end

  def add_wagon(wagon)
    speed == 0 && appropriate_wagon?(wagon) ? self.wagons << wagon : raise "Can's add wagon while moving!"
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
    speed == 0 ? self.wagons.pop : raise "Can's add wagon while moving!"
  end

  def appropriate_wagon?(wagon) #Вроде дублирования кода и избежали, но архитектурно мне кажется это менее удачно. У нас предок как будто знает что-то о своих потомках и предоставляет для них методы. Это нормально?
    wagon.type == self.type
  end

  private

  def self.trains
    @@trains
  end


end
