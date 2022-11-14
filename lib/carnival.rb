class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    rides.max do |ride_a, ride_b|
      ride_a.rider_log.values.sum <=> ride_b.rider_log.values.sum
    end.name
  end

  def most_profitable_ride
    @rides.max do |ride_a, ride_b|
      ride_a.total_revenue <=> ride_b.total_revenue       # ride.rider_log.values.sum
    end
  end
end
