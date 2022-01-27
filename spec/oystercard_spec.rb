require 'oystercard'



describe Oystercard do
  
  let(:station){ double :station }
  
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

  # it 'can deduct money' do
  #   card = Oystercard.new
  #   card.top_up(60)
  #   expect(card.deduct(20)).to eq "20 deducted from account"
  # end

  it 'can check customer is on a journey' do
    card = Oystercard.new
    expect(card.in_journey?).to eq false
  end

  it 'can check customer is not on a journey' do
    card = Oystercard.new
    card.touch_in("Preston")
    expect(card.in_journey?).to eq true
  end

  it 'can touch a user in' do
    card = Oystercard.new
    expect(card.touch_in("Preston")).to eq true
  end

  it 'can touch a user out' do
    card = Oystercard.new
    card.top_up(20)
    expect(card.touch_out).to eq "Thank you for riding with us today"
  end

  it 'has a minimum balance of £1' do
    card = Oystercard.new
    expect{card.touch_out}.to raise_error "insufficient funds"
  end


  it 'can deduct money on touch out' do
    card = Oystercard.new
    subject.top_up(10)
    card.touch_in("Preston")
    expect{subject.touch_out}.to change {subject.balance}.by(-Oystercard::MIN_BALANCE)
  end

  it 'saves starting station' do
    card = Oystercard.new
    subject.touch_in("Preston")
    expect(subject.entry_station).to eq "Preston"
  end

end
