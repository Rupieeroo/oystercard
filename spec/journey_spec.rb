require 'journey'

describe Journey do

  let (:station) { double :station }
  let (:station_2) { double :station }
  before (:each) { subject }


  it 'is a completed journey' do
    expect(subject.complete?).to eq true
  end

  it 'can store entry station' do
    expect(subject.entry_station(station)).to eq station
  end

  it 'can store exit station' do
    expect(subject.exit_station(station_2)).to eq station_2
  end

  it 'has a constant, minimum fare, which is 1' do
    expect(Journey::MIN_FARE).to eq 1
  end

  it 'charges the minimum fare' do
    expect(subject.fare).to eq Journey::MIN_FARE
  end
end
