class Visitor
  attr_reader :name, 
              :height, 
              :spending_money,
              :preferences,
              :money_spent

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.tr("$","").to_i
    @preferences = []
    @money_spent = 0
  end

  def add_preference(preference)
    preferences << preference
  end

  def tall_enough?(required_height)
    height >= required_height
  end

  def charge(amount)
    @spending_money -= amount
    @money_spent += amount
  end
end