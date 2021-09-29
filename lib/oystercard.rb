require_relative 'journey'

class Oystercard

  attr_reader :balance, :in_use, :entry_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  
  def initialize(journey = Journey.new)
    @balance = 0
    @minimum_balance = MINIMUM_BALANCE
    @maximum_balance = MAXIMUM_BALANCE
    @entry_station = nil
    @journeys = journey
  end


  def top_up(amount)
    if maximum_balance_exceeded?(amount)
      raise "Top up limit exceeded. Maximum balance must be £#{@maximum_balance}" 
    else
      @balance += amount
    end
  end
  
  def touch_in(entry_station)
    if balance_too_low?
      raise "Balance is too low. Minimum balance must be £#{@minimum_balance}" 
    else
      @journeys.start_journey(entry_station)
    end
  end
  
  def touch_out(exit_station)
    @journeys.end_journey(exit_station)
    deduct(@journeys.fare)
  end
  
  def in_journey?
    @entry_station != nil
  end
  
  private
  
  def deduct(amount = MINIMUM_CHARGE)
    @balance -= amount
  end

  def maximum_balance_exceeded?(amount)
    @balance + amount > @maximum_balance
  end

  def balance_too_low?
    @balance < @minimum_balance
  end
end
