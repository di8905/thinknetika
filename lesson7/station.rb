require_relative 'validation.rb'

class Station

include Validation

attr_accessor :name, :trains

NAME_FORMAT = /^\w+/

@@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!(name, NAME_FORMAT)
    @@stations << self
  end

  def valid?
    validate!(self.name, NAME_FORMAT)
   rescue
    false
  end

  def train_arrive!(train)
    @trains << train
  end

  def list_trains
    self.trains.each_with_index {|train, i| puts "#{i+1}) #{train.number}, #{train.type}"}
  end

  def trains_each(&block)
    self.trains.each {|train| block.call(train)} if block_given?
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

  def train_departure!(train)
    @trains.delete(train)
  end

end
