class Visitor
  attr_reader :name, 
              :height, 
              :spending_money,
              :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.tr("$","").to_i
    @preferences = []
  end

  def add_preference(preference)
    preferences << preference
  end

  def tall_enough?(required_height)
    height >= required_height
  end
end