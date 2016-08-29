require_relative 'validation.rb'

class Route
  include Validation
  attr_reader :waypoints

  def initialize(start, finish)
    @waypoints = []
    @waypoints << start << finish
  end

  def add_waypoint!(station)
    @waypoints.insert(-2, station)
  end

  def delete_waypoint!(station)
    @waypoints.delete(station)
  end

  def print
    @waypoints.each { |point| puts "Station #{point.name}\n" }
  end
end
