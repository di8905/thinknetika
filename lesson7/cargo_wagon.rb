require_relative 'wagon.rb'

class CargoWagon < Wagon
  attr_reader :capacity, :load

  def initialize(capacity = 30)
    @capacity = capacity
    @type     = :cargo
    @load     = 0
  end

  def load!(val)
    self.load += val if (self.load + val) < capacity
  end

  def available_capacity
    self.capacity - self.load
  end

  private
  attr_writer :load

end
