class Journey
  
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  attr_reader :journeys, :entry_station, :exit_station

  def initialize
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare
    if incomplete_journey?
      log_journey(entry_station, exit_station, PENALTY_CHARGE)
    else
      log_journey(entry_station, exit_station, MINIMUM_CHARGE)
    end
  end
  
  def in_journey?
    @entry_station != nil
  end

  private

  def log_journey(entry_station, exit_station, charge)
    journeys << {entry_station: entry_station, exit_station: exit_station}
    reset_journey
    charge
  end

  def incomplete_journey?
    @exit_station == nil || @entry_station == nil
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
  end

end
