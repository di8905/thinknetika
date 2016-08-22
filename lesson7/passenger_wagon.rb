require_relative 'wagon.rb'

class PassengerWagon < Wagon
  attr_reader :seats_quantity
  def initialize(seats_quantity)
    @seats_quantity = seats_quantity
    @taken_seats    = 0
    @type           = :passenger
  end


end
