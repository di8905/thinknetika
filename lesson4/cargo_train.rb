require_relative 'train.rb'

class CargoTrain < Train

  def initialize(number) #Имхо предыдущий вариант был проще и лучше, хоть и с дублированием кода. Тут же пришлось в родительский класс писать атрибуты и методы которые в родительском могут и не понадобиться. Или есть способ еще красивее сделать?
    super(number)
    @type = :cargo
  end

end
