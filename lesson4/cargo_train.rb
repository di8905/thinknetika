require_relative 'train.rb'

class CargoTrain < Train

  def type
    :cargo
  end

  def add_wagon(wagon)
    wagon.type == self.type ? add_wagon!(wagon) : puts("Wrong wagon type! Can't do it.")
  end

end
