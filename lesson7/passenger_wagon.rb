require_relative 'wagon.rb'

class PassengerWagon < Wagon
  attr_reader :seats_quantity, :taken_seats
  def initialize(seats_quantity)
    @seats_quantity = seats_quantity
    @taken_seats    = 0
    @type           = :passenger
  end

  def take_seat
    @taken_seats += 1 if @taken_seats < @seats_quantity
  end

  def available_seats
    :seats_quantity - :taken_seats
  end


end