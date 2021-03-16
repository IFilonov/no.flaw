class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :female, optional: true
  include DeviseDefs

  scope :pair, -> { pairs.find_by(female: self, male: male, divorced_at: nil) }

  def create_pair!(pair)
    @female = Female.create!(pair)
    update!(female: @female)
    create_pair_history!
    info
  end

  def delete_pair!
    pairs.active.first.update!(divorced_at: Time.zone.now)
    update!(female: nil)
  end

  def update_pair!(pair)
    @female = female
    @female&.update!(pair)
    info
  end

  def restore_pair!(username)
    update!(female: Female.find_by!(username: username))
    create_pair_history!
  end

  def info
    @female ||= reload.female
    { me: { username: username },
      pair: { username: @female&.username, nickname: @female&.nickname,
              pair_created_at: pairs.active_created } }
  end

  def pairs_history
    pairs.history.includes(:female).order(:id).map do |pair|
      { username: pair.female.username,
        nickname: pair.female.nickname,
        created_at: pair.created_at,
        divorced_at: pair.divorced_at }
    end
  end

  def set_fire_date(fire_dates)
    lifetime = lifetimes.create!(fire_date: fire_dates)
    { created_at: lifetime.created_at }
  end

  def lifetime_dates
    female_lifetime = female&.lifetimes&.last
    { taboo_dates: female_lifetime&.taboo_date,
      fire_dates: lifetimes&.last&.fire_date,
      pair_fire_dates: female_lifetime&.fire_date }
  end

  private

  def create_pair_history!
    pairs.create!(female: female)
  end
end
