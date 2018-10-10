require_relative 'station'

class Journey
  attr_reader :from, :to, :journeys

  MIN_FARE = 1

  def initialize
    @from = nil
    @to = nil
    @journeys = []
  end

  def entry_station(station)
    @from = station
  end

  def finish(station)
    @to = station
    @journeys.push({from: @from, to: @to))
    @from, @to = nil, nil
  end

  def in_journey?
    !@from.nil?
  end

  def complete?
    @from.nil? && @to.nil?
  end

  def fare
    MIN_FARE
  end


end
