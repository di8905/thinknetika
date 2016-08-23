require_relative 'wagon.rb'

class PassengerWagon < Wagon

  def initialize(capacity = 48)
    super
    @type = :passenger
  end

  def take_seat
    self.load += 1 if self.load < @capacity
  end
end
