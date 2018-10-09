class Oystercard
  attr_reader :balance, :entry_station, :journeys

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def in_journey?
    !@entry_station.nil?
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
    deduct(MIN_FARE)
    @journeys.push({
      from: @entry_station,
      to: station
      })
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
