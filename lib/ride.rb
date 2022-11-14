class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue, 
              :rider_log

  def initialize(info)
    @name = info[:name]
    @min_height = info[:min_height]
    @admission_fee = info[:admission_fee]
    @excitement = info[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(visitor)
    # require 'pry'; binding.pry
    if visitor.preferences.any? {|preference| preference  == excitement} && visitor.height >= min_height
      visitor.pay(admission_fee)
      rider_log[visitor] += 1

      @total_revenue += admission_fee
  end

  
  end
end
