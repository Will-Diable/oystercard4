class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :in_journey
  attr_reader :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance reached" if @balance >= MAX_BALANCE
    @balance += amount
    "#{@balance} added to account"
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
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

p card = Oystercard.new
p card.top_up(10)
p card.touch_in("Preston")
p card.entry_station


