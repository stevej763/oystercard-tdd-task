require 'station'

describe Station do
  let(:subject) { described_class.new('Camden', 'Zone 2') }

  describe '#initialize' do
    it 'should create a station with name' do
      expect(subject.name).to eq 'Camden'
    end

    it 'should create a station with zone' do
      expect(subject.zone).to eq 'Zone 2'
    end
  end
end