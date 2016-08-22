require_relative 'manufacturer.rb'
require          'securerandom'

class Wagon
  include Manufacturer
  attr_reader :type, :serial, :capacity, :load

  def initialize(capacity)
    @serial   = SecureRandom.uuid
    @capacity = capacity
    @load     = 0
  end

  def space_avail
    self.capacity - self.load
  end

  protected

  attr_writer :load

end
