class Visitor
    attr_reader :name, :height, :spending_money, :preferences
    def initialize(name, height, money)
        @name = name
        @height = height
        @spending_money = (money.delete'$').to_i
        @preferences = []
    end

end
