require_relative 'wagon.rb'

class CargoWagon < Wagon
  attr_reader :capacity, :load

  def initialize(capacity = 30)
    super
    @type = :cargo
    @load = 0
  end

  def load!(val)
    self.load += val if (load + val) < capacity
  end
end
