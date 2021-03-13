class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :female, optional: true
  include DeviseDefs

  def create_pair!(pair)
    @female = Female.create!(pair)
    update!(female: @female)
    create_pair_history!
    names
  end

  def delete_pair!
    update!(female: nil)
    pairs.find_by(divorced_at: nil).update(divorced_at: Time.zone.now)
  end

  def update_pair!(pair)
    @female = female
    @female&.update!(pair)
    names
  end

  def restore_pair!(username)
    update!(female: Female.find_by!(username: username))
  end

  def names
    @female ||= reload.female
    { me: { username: username },
      pair: { username: @female&.username, nickname: @female&.nickname } }
  end

  def pairs_history
    pairs.includes(:female).order(:id).map do |pair|
      pair_created = pair.created_at.strftime("%H:%M %d.%m.%Y")
        #"#{date.hour}:#{date.min} #{date.day}.#{date.month}.#{date.year}"
      { username: pair.female.username,
        nickname: pair.female.nickname,
        start_time: pair_created }
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
