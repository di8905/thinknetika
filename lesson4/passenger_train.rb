require_relative 'train.rb'

class PassengerTrain < Train

  def type
    :passenger
  end

  def add_wagon(wagon)
    wagon.type == self.type ? add_wagon!(wagon) : puts("Wrong wagon type! Can't do it.")
  end

end
