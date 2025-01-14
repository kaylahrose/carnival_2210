require './lib/carnival'
require './lib/ride'
require './lib/visitor'

RSpec.describe Carnival do
  it 'exists' do
    carnival = Carnival.new(3)
    expect(carnival.duration).to eq(3)
    expect(carnival.rides).to eq([])
  end

  it '#add_ride' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    carnival.add_ride(ride1)
    expect(carnival.rides).to eq([ride1])
  end

  it '#most_popular_ride' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    visitor2.add_preference(:thrilling)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(carnival.most_popular_ride).to eq(ride1.name)
  end

  it '#most_profitable_ride' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    visitor2.add_preference(:thrilling)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(carnival.most_profitable_ride).to eq(ride1)

    6.times { ride3.board_rider(visitor3) }
    expect(carnival.most_profitable_ride).to eq(ride3)
  end

  it '#total_revenue' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    visitor2.add_preference(:thrilling)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(carnival.total_revenue).to eq(5)

    6.times { ride3.board_rider(visitor3) }
    expect(carnival.total_revenue).to eq(17)
  end

  it '#summary' do
    carnival = Carnival.new(3)
    ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1 = Visitor.new('Bruce', 54, '$10')
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor3.add_preference(:thrilling)
    visitor2.add_preference(:thrilling)
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    ride1.board_rider(visitor1)
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)

    expect(carnival.summary).to eq({ visitor_count: 3,
                                     revenure_earned: carnival.total_revenue,
                                     visitor_details: { 'Bruce' => { favorite_ride: ride1.name,
                                                                     total_spent: 2 },
                                                        'Tucker' => { favorite_ride: ride1.name,
                                                                      total_spent: 1 },
                                                        'Penny' => { favorite_ride: ride3.name,
                                                                     total_spent: 2 } },
                                     ride_details: { 'Carousel' => { riders: [visitor1.name, visitor2.name],
                                                                     total_revenue: 3 },
                                                     'Ferris Wheel' => { riders: [],
                                                                         total_revenue: 0 },
                                                     'Roller Coaster' => { riders: [visitor3.name],
                                                                           total_revenue: 2 } } })

    5.times { ride3.board_rider(visitor3) }
    visitor3.add_preference(:gentle)
    ride1.board_rider(visitor3)

    expect(carnival.summary).to eq({ visitor_count: 3,
                                     revenure_earned: carnival.total_revenue,
                                     visitor_details: { 'Bruce' => { favorite_ride: ride1.name,
                                                                     total_spent: 2 },
                                                        'Tucker' => { favorite_ride: ride1.name,
                                                                      total_spent: 1 },
                                                        'Penny' => { favorite_ride: ride3.name,
                                                                     total_spent: 13 } },
                                     ride_details: { 'Carousel' => { riders: [visitor1.name, visitor2.name, visitor3.name],
                                                                     total_revenue: 4 },
                                                     'Ferris Wheel' => { riders: [],
                                                                         total_revenue: 0 },
                                                     'Roller Coaster' => { riders: [visitor3.name],
                                                                           total_revenue: 12 } } })
  end
end
