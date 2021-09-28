require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  describe '#initialize' do
    it 'should set journeys to a empty array' do
      expect(subject.journeys).to eq []  
    end
  end

  describe '#start journey' do
    it 'set the entry station for the journey' do
      subject.start_journey(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#end journey' do
    it 'should set the exit station' do
      subject.end_journey(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#in_journey' do
    it 'should return true when in use' do
      subject.start_journey(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it 'should return false when not in use' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#fare' do
    it 'should set entry station to nil' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      subject.fare
      expect(subject.entry_station).to eq nil
    end
    it 'should set exit station to nil' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      subject.fare
      expect(subject.exit_station).to eq nil
    end

    it 'should store latest journey' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      subject.fare
      expect(subject.journeys).to include({ entry_station: entry_station, exit_station: exit_station})
    end

    it 'should store history of journeys' do
      3.times do 
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      subject.fare
      end

      expected = [
        { entry_station: entry_station, exit_station: exit_station},
        { entry_station: entry_station, exit_station: exit_station},
        { entry_station: entry_station, exit_station: exit_station}
      ]
      expect(subject.journeys).to eq expected
    end

    it 'should charge minimum for the journey' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject.fare).to eq 1
    end

    it 'should charge penalty for missing exit station' do
      subject.start_journey(entry_station)
      expect(subject.fare).to eq 6
    end
    
    it 'should charge penalty for missing entry station' do
      subject.end_journey(exit_station)
      expect(subject.fare).to eq 6
    end

  end
end