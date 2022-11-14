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
      ride_a.total_revenue <=> ride_b.total_revenue
    end
  end

  def total_revenue
    rides.sum { |ride| ride.total_revenue }
  end

  def summary
    # see spec test for expected return
    visitors = rides.map do |ride|
      ride.rider_log.keys
    end.flatten.uniq

    v = {}
    visitors.each { |visitor| v[visitor.name] = visitor.details }
    r = {}
    rides.each { |ride| r[ride.name] = ride.details }
    { visitor_count: visitors.count,
      revenure_earned: total_revenue,
      visitor_details: v,
      ride_details: r }
  end
end
