require './spec_helper'

RSpec.describe Carnival do
  before(:each) do
    @carnival = Carnival.new(7)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
  end

  it 'exists' do
    expect(@carnival).to be_a(Carnival)
  end

  it 'had a duration (days)' do
    expect(@carnival.duration).to eq(7)
  end

  it 'starts with no rides, but can add and list them' do
    expect(@carnival.rides).to eq([])
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @carnival.add_ride(@ride3)

    expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
  end

  it 'can determine which ride is most popular (ridden the most)' do
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)

    @ride2.board_rider(@visitor1)
    @ride2.board_rider(@visitor2)

    3.times do
      @ride1.board_rider(@visitor1)
    end

    expect(@carnival.most_popular_ride).to eq(@ride1)
  end

  it 'can determine which ride is most profitable' do
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)

    @ride2.board_rider(@visitor1)
    @ride2.board_rider(@visitor2)

    3.times do
      @ride1.board_rider(@visitor1)
    end

    expect(@carnival.most_profitable_ride).to eq(@ride2)
  end

  it 'can determine total revenue across all rides' do
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)

    @ride2.board_rider(@visitor1)
    @ride2.board_rider(@visitor2)

    3.times do
      @ride1.board_rider(@visitor1)
    end

    expect(@carnival.total_revenue).to eq(13)
  end

  it 'has a summary' do
    @carnival.add_ride(@ride1)
    @carnival.add_ride(@ride2)
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @ride2.board_rider(@visitor1)
    @ride2.board_rider(@visitor2)
    3.times do
      @ride1.board_rider(@visitor1)
    end
    
    expected = {
      :visitor_count=>2,
      :revenue_earned=>13,
      :visitors=>[@visitor1, @visitor2],
      :rides=>
       [@ride1, @ride2]
      }
    expect(@carnival.summary).to eq(expected)
  end
end