require 'oystercard'

describe Oystercard do
  let (:station) { double :station }
  let (:station_2) { double :station }

  describe "#balance" do
    it "should report intial balance as 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "should increase the balance by 10" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "should raise an error if balance exceeds LIMIT" do
      subject.top_up(Oystercard::LIMIT)
      expect { subject.top_up(1) }.to raise_error "Card limit of #{Oystercard::LIMIT} exceeded"
    end
  end

  describe "#in_journey" do
    it { is_expected.not_to be_in_journey }
  end

  describe "#touch_in" do
    it "should be able to touch in" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "should not be able to touch in if balance is below the minimum fare" do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance"
    end

    it "should remember the entry station" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#touch_out" do
    before {
      subject.top_up(Oystercard::MIN_FARE)
    }

    it "should be able to touch out" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "should deduct money on touch out" do
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
    end

    it "should clear the entry station" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to be_nil
    end

    it "should charge the penalty fare if no entry station" do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::PEN_FARE)
    end

  end

  it "should start with an empty journey history" do
    expect(subject.journeys).to be_empty
  end


  it "should remember the journey history" do
    subject.top_up(Oystercard::MIN_FARE)
    subject.touch_in(station)
    subject.touch_out(station_2)
    expect(subject.journeys[0].from).to eq station
    expect(subject.journeys[0].to).to eq station_2
  end

  describe "#fare" do
    it "reports the correct fare" do
      expect(subject.fare).to eq Oystercard::MIN_FARE
    end
  end

end
