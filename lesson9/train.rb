require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'station.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  attr_accessor :current_station, :wagons
  attr_reader :route, :number, :speed
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String
  validate :current_station, :type, Station

  @@trains = {}

  class << self
    def find(number)
      @@trains.find { |train| train.number == number }
    end

    def trains
      @@trains
    end
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @current_station = Station.new("empty default station")
    validate!
    @@trains[number] = self
    register_instance
  end

  def accelerate!(speed)
    @speed = speed
  end

  def stop!
    @speed = 0
  end

  def route=(route)
    @route = route
    current_station = @route.waypoints[0]
    current_station.train_arrive!(self)
  end

  def move!(station) # For moving between stations without routes
    current_station.train_departure!(self) if current_station
    self.current_station = station
    current_station.train_arrive!(self)
  end

  def get_to!(station) # Moves on routes
    if route.waypoints.find_index(station)
      current_station.train_departure!(self)
      self.current_station = station
      current_station.train_arrive!(self)
    end
  end

  def last_station
    route.waypoints[location - 1].name
  end

  def wagons_count
    wagons.length
  end

  def remove_wagon
    remove_wagon! if wagons.!empty?
  end

  def add_wagon(wagon)
    return unless appropriate_wagon?(wagon)
    raise("Can's add wagon while moving!") unless speed.zero?
    wagons << wagon
  end

  def each_wagon
    wagons.each { |wagon| yield(wagon) } if block_given?
  end

  def next_station
    route.waypoints[location + 1].name
  end

  protected

  def location
    route.waypoints.find_index(current_station)
  end

  def remove_wagon!
    speed.zero? ? wagons.pop : raise("Can's add wagon while moving!")
  end

  def appropriate_wagon?(wagon)
    wagon.type == type
  end
end
