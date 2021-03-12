class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  has_one :male
  include DeviseDefs

  def create_pair_history!
    pairs.create!(male: male)
  end

  def create_pair!(pair)
    @male = Male.create!(pair)
    update!(male: @male)
    names
  end

  def delete_pair!
    update!(male: nil)
  end

  def update_pair!(pair)
    @male = male
    @male&.update!(pair)
    names
  end

  def restore!(username)
    update!(male: Male.find_by!(username: username))
  end

  def names
    @male ||= reload.male
    { me: { username: username },
      pair: { username: @male&.username, nickname: @male&.nickname } }
  end

  def pairs_history
    pairs.includes(:male).order(:id).map do |pair|
      { username: pair.male.username,
        nickname: pair.male.nickname }
    end
  end

  def set_fire_date(fire_dates)
    lifetime = lifetimes.create!(taboo_date: lifetimes.last&.taboo_date,
                                 fire_date: fire_dates)
    { created_at: lifetime.created_at }
  end

  def set_taboo_date(taboo_dates)
    lifetime = lifetimes.create!(fire_date: lifetimes.last&.fire_date,
                                 taboo_date: taboo_dates)
    { created_at: lifetime.created_at }
  end
end
