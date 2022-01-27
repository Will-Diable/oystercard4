require 'oystercard'

describe Oystercard do
  
  let(:entry_station){ double 'Preston' }

  # This also works: let(:entry_station){ double :entry_station }
  
  card = Oystercard.new
  it {is_expected.to respond_to :balance}

  it 'checks balance' do
    expect(subject.balance).to eq 0
  end

  it 'can top-up balance' do
    expect(subject.top_up(20)).to eq "20 added to account"
  end

  it 'has a maximum balance of £90' do
    expect{subject.top_up(91)}.to raise_error "Maximum balance reached"
  end

  it 'can check customer is on a journey' do
    expect(subject.in_journey?).to eq false
  end

  it 'can check customer is not on a journey' do
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq true
  end

  it 'can touch a user in' do
    expect(subject.touch_in(entry_station)).to eq entry_station
  end

  it 'can touch a user out' do
    subject.top_up(20)
    expect(subject.touch_out).to eq "Thank you for riding with us today"
  end

  it 'has a minimum balance of £1' do
    expect{subject.touch_out}.to raise_error "insufficient funds"
  end


  it 'can deduct money on touch out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect{subject.touch_out}.to change {subject.balance}.by(-Oystercard::MIN_BALANCE)
  end

  it 'saves entry station' do
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'begins with an empty journey list' do
    expect(subject.journeys).to be_empty
  end

end
