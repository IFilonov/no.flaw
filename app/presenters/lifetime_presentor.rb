class LifetimePresentor
  def initialize(lifetimes, pair)
    @lifetime = lifetimes.last
    @pair_lifetime = pair&.lifetimes&.last
  end

  def dates
    { taboo_dates: @lifetime&.taboo_date,
      fire_dates: @lifetime&.fire_date,
      pair_fire_dates: @pair_lifetime&.fire_date }
  end
end