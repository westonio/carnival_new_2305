class Carnival
  attr_reader :duration,
              :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    rides << ride
  end

  def most_popular_ride
    rides.max_by { |ride| ride.rider_log.values.sum }
  end

  def most_profitable_ride
    rides.max_by { |ride| ride.total_revenue }
  end

  def total_revenue
    rides.sum { |ride| ride.total_revenue}
  end

  def summary
    {
      visitor_count: visitor_count,
      revenue_earned: total_revenue,
      visitors: visitors_summary,
      rides: rides_summary
    }
  end

  #helper for .visitor_count and .visitors_summary
  def unique_visitors
    rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq
  end

  #helper for .summary
  def visitor_count
    unique_visitors.count
  end

  #helper for .visitors_summary
  def favorite_ride(visitor)
    rides.max_by { |ride| ride.rider_log[visitor] }
  end
  
  #helper for .summary
  def visitors_summary
    unique_visitors.each do |visitor|
      {
        visitor: visitor,
        favorite_ride: favorite_ride(visitor),
        total_money_spent: visitor.money_spent
      }
    end
  end

  #helper for .summary
  def rides_summary
    rides.each do |ride|
      {
        ride: ride,
        riders: ride.rider_log.keys,
        total_revenue: ride.total_revenue
      }
    end
  end
end