class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @minimum_balance = MINIMUM_BALANCE
    @maximum_balance = MAXIMUM_BALANCE
    @in_use = false
  end

  attr_reader :balance, :in_use

  def top_up(amount)
    if maximum_balance_exceeded?(amount)
      raise "Top up limit exceeded. Maximum balance must be £#{@maximum_balance}" 
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -=amount
  end

  def touch_in
    if balance_too_low?
      raise "Balance is too low. Minimum balance must be £#{@minimum_balance}" 
    else
      @in_use = true
    end
  end

  def touch_out
    @in_use = false
  end
  
  def in_journey?
    @in_use
  end

  private

  def maximum_balance_exceeded?(amount)
    @balance + amount > @maximum_balance
  end

  def balance_too_low?
    @balance < @minimum_balance
  end
end