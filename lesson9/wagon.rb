require_relative 'manufacturer.rb'
require          'securerandom'

class Wagon
  include Manufacturer

  attr_accessor :load
  attr_reader :type, :serial, :capacity

  def initialize(capacity)
    @serial   = SecureRandom.uuid
    @capacity = capacity
    @load     = 0
  end

  def space_avail
    capacity - load
  end
end
