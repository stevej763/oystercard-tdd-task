class Oystercard

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @maximum_balance = MAXIMUM_BALANCE
  end

  attr_reader :balance

  def top_up(amount)
    raise "Top up limit exceeded" if maximum_balance_exceeded?(amount)
    @balance += amount
  end
end

private

def maximum_balance_exceeded?(amount)
  @balance + amount > @maximum_balance
end