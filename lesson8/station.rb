require_relative 'validation.rb'

class Station
  include Validation

  NAME_FORMAT = /^\w+/

  attr_accessor :name, :trains

  @stations = []

  class << self
    attr_accessor :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!(name, NAME_FORMAT)
    self.class.stations << self
  end

  def valid?
    validate!(name, NAME_FORMAT)
  rescue
    false
  end

  def train_arrive!(train)
    @trains << train
  end

  def list_trains
    trains.each_with_index do |train, i|
      puts "#{i + 1}) #{train.number}, #{train.type}"
    end
  end

  def each_train
    trains.each { |train| yield(train) } if block_given?
  end

  def list_trains_of_type(type)
    count = 0
    @trains.each do |train|
      if train.type == type
        puts train.number
        count += 1
      end
    end
    puts "There is #{count} #{type} trains on the station #{name}"
  end

  def train_departure!(train)
    @trains.delete(train)
  end
end
