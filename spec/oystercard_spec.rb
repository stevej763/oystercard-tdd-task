require 'Oystercard'

describe Oystercard do
  describe '#balance' do
    it 'has a balance' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should top up the balance by 10' do
      subject.top_up(10)
      expect(subject.balance).to eq 10.0
    end

    it 'should throw an error when topup limit exceeded' do
      expect { subject.top_up(100) }.to raise_error 'Top up limit exceeded. Maximum balance must be £90'
    end
  end
end
