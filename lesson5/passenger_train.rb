require_relative 'train.rb'

class PassengerTrain < Train

  attr_reader :type

  def initialize(number, manufacturer) #Имхо предыдущий вариант был проще и лучше, хоть и с дублированием кода. Тут же пришлось в родительский класс писать атрибуты и методы которые в родительском могут и не понадобиться. Или есть способ еще красивее сделать?
    super
    @type = :passenger
  end

end
