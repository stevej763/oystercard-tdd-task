require 'Oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { double :journey, start_journey: entry_station, end_journey: exit_station, fare: 1 }
  let(:subject) { described_class.new(journey) } 

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
      expect(journey).to receive(:start_journey).with(entry_station)
      subject.touch_in(entry_station)
    end

    it 'should throw an error when balance is below minimum' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Balance is too low. Minimum balance must be £1'
    end
  end

  describe '#touch-out' do

    it 'should reduce the balance' do
      expect(journey).to receive(:fare).and_return 1
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-1)
    end

    it 'should end the journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(journey).to receive(:end_journey).with(exit_station)
      subject.touch_out(exit_station)
    end
  end
end
