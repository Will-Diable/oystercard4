class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :in_journey
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum balance reached" if @balance + amount > MAX_BALANCE
    @balance += amount
    "#{@balance} added to account"
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station2)
    deduct(MIN_BALANCE)
    @exit_station = station2
    @journeys[@entry_station] = @exit_station
    @entry_station = nil
    "Thank you for riding with us today"
  end

  private
  def deduct(amount)
    fail "insufficient funds" if @balance < MIN_BALANCE
    @balance -= amount
    "#{amount} deducted from account"
  end
  
end

