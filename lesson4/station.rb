class Station

attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrive!(train)
    @trains << train
  end

  def list_trains #Это метод для всех поездов на станции
    self.trains.each_with_index {|train, i| puts "#{i+1}) #{train.number}, #{train.type}, #{train.wagons_num} wagons"}
  end

  def list_trains_of_type(type)
    count = 0
    @trains.each do |train|
      if train.type == type
        puts train.number
        count += 1
      end
    end
    puts "There is #{count} #{type} trains on the station #{self.name}"
  end

  # def trains_number_by_type
  #   passenger_train_count = 0
  #   freight_train_count   = 0
  #   @trains.each {|train| train.freight? ? freight_train_count += 1 : passenger_train_count += 1 }
  #   puts "There is #{passenger_train_count} passenger train(s) on #{self.name}"
  #   puts "There is #{freight_train_count} freight train(s) on #{self.name}"
  # end

  def train_departure!(train)
    @trains.delete(train)
  end

end
