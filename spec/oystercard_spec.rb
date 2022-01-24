require 'oystercard'

describe Oystercard do
  
  card = Oystercard.new
  it {is_expected.to respond_to :balance}

  it 'checks balance' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it 'can top-up balance' do
    card = Oystercard.new
    expect(card.top_up(20)).to eq "20 added to account"
  end

  it 'has a maximum balance of £90' do
    card = Oystercard.new
    # initial deposit
    card.top_up(90)
    # second deposit
    expect{card.top_up(20)}.to raise_error "Maximum balance reached"
  end

  it 'can deduct money' do
    card = Oystercard.new
    card.top_up(60)
    expect(card.deduct(20)).to eq "20 deducted from account"
  end

  it 'can check is customer is on a journey' do
    card = Oystercard.new
    expect(card.in_journey?).to eq false
  end

  it 'can touch a user in' do
    card = Oystercard.new
    expect(card.touch_in).to eq true
  end

  it 'can touch a user out' do
    card = Oystercard.new
    expect(card.touch_out).to eq false
  end

end