require_relative 'train.rb'

class PassengerTrain < Train

  def initialize(number) #Имхо предыдущий вариант был проще и лучше, хоть и с дублированием кода. Тут же пришлось в родительский класс писать атрибуты и методы которые в родительском могут и не понадобиться. Или есть способ еще красивее сделать?
    super(number)
    @type = :passenger
  end

  def add_wagon(wagon)
    wagon.type == self.type ? add_wagon!(wagon) : puts("Wrong wagon type! Can't do it.")
  end

end
