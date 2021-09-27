class Oystercard
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
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
    @in_use = true
  end

  def in_journey?
  end

  private

  def maximum_balance_exceeded?(amount)
    @balance + amount > @maximum_balance
  end
end