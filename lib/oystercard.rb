require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station

  LIMIT = 90
  MIN_FARE = 1
  PEN_FARE = 6

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "Card limit of #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end


  def touch_in(station)
    raise "Insufficient balance" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    #something here
    @entry_station == nil ? deduct(PEN_FARE) : deduct(fare)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
