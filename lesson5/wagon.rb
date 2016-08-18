require_relative 'manufacturer.rb'
class Wagon
  include Manufacturer
  attr_reader :type
end
