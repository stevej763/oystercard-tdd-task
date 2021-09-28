require 'Oystercard'

describe Oystercard do
  let(:station) { double :station }

  describe '#initialize' do
    it 'should set journeys to a empty array' do
      expect(subject.journeys).to eq []  
    end
  end

  describe '#balance' do
    it 'has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should top up the balance by 10' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it 'should throw an error when topup limit exceeded' do
      expect { subject.top_up(100) }.to raise_error 'Top up limit exceeded. Maximum balance must be £90'
    end
  end

  describe '#touch-in' do

    it 'should set entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'should throw an error when balance is below minimum' do
      expect { subject.touch_in(station) }.to raise_error 'Balance is too low. Minimum balance must be £1'
    end
  end

  describe '#touch-out' do

    it 'should set entry station to nil' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

    it 'should reduce the balance by £1' do
      expect { subject.touch_out }.to change{ subject.balance }.by(-1)
    end

    it 'should store journey history' do
      exit_station = double :exit_station
      expect(subject.journeys).to include({ :entry_station => station, :exit_station => exit_station})
    end
  end

  describe '#in_journey' do
    it 'should return true when in use' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it 'should return false when not in use' do
      expect(subject.in_journey?).to eq false
    end
  end
end
