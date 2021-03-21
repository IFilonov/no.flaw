class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :female, optional: true
  include DeviseDefs

  scope :pair, -> { pairs.find_by(female: self, male: male, divorced_at: nil) }

  def create_pair!(pair)
    female = Female.create!(pair)
    update!(female: female)
    create_pair_history!
    info
  end

  def delete_pair!
    pairs.active.first.update!(divorced_at: Time.zone.now)
    update!(female: nil)
  end

  def update_pair!(pair)
    female&.update!(pair)
    info
  end

  def restore_pair!(username)
    update!(female: Female.find_by!(username: username))
    create_pair_history!
  end

  def info
    UserInfoPresentor.new(self, female).info
  end

  def pairs_history
    pairs.history.includes(:female).order(:id).map(&:female_info)
  end

  def set_fire_date(fire_dates)
    lifetime = lifetimes.create!(fire_date: fire_dates)
    { created_at: lifetime.created_at }
  end

  def lifetime_dates
    LifetimePresentor.new(lifetimes, female.lifetimes).male_dates
  end

  private

  def create_pair_history!
    pairs.create!(female: female)
  end
end
