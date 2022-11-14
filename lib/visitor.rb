class Visitor
  attr_reader :name, :height, :spending_money, :preferences, :rides, :budget

  def initialize(name, height, money)
    @name = name
    @height = height
    @spending_money = (money.delete '$').to_i
    @preferences = []
    @rides = Hash.new(0)
    @budget = (money.delete '$').to_i
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(height_requirement)
    height >= height_requirement
  end

  def pay(fee)
    @spending_money -= fee
  end

  def ride_count(ride)
    @rides[ride] += 1
  end

  def details
    { favorite_ride: rides.max_by { |_k, v| v }[0].name,
      total_spent: budget - spending_money }
  end
end
