require_relative 'train.rb'

class CargoTrain < Train

  attr_reader :type

  def initialize(number, manufacturer) 
    super
    @type = :cargo
  end

end
