class LifetimePresentor
  def initialize(lifetimes, pair_lifetimes)
    @lifetime = lifetimes.last
    @pair_lifetime = pair_lifetimes&.last
  end

  def female_dates
    { taboo_dates: @lifetime&.taboo_date,
      fire_dates: @lifetime&.fire_date,
      pair_fire_dates: @pair_lifetime&.fire_date }
  end

  def male_dates
    { taboo_dates: @pair_lifetime&.taboo_date,
      fire_dates: @lifetime&.fire_date,
      pair_fire_dates: @pair_lifetime&.fire_date }
  end
end
