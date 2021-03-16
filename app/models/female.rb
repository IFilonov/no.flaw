class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  has_one :male
  include DeviseDefs

  def create_pair!(pair)
    @male = Male.create!(pair)
    update!(male: @male)
    create_pair_history!
    info
  end

  def delete_pair!
    pairs.active.first.update!(divorced_at: Time.zone.now)
    update!(male: nil)
  end

  def update_pair!(pair)
    @male = male
    @male&.update!(pair)
    info
  end

  def restore_pair!(username)
    update!(male: Male.find_by!(username: username))
    create_pair_history!
  end

  def info
    @male ||= reload.male
    { me: { username: username },
      pair: { username: @male&.username, nickname: @male&.nickname,
              pair_created_at: pairs.active_created } }
  end

  def pairs_history
    pairs.history.includes(:male).order(:id).map do |pair|
      { username: pair.male.username,
        nickname: pair.male.nickname,
        created_at: pair.created_at,
        divorced_at: pair.divorced_at }
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

  def lifetime_dates
    lifetime = lifetimes&.last
    { taboo_dates: lifetime&.taboo_date,
      fire_dates: lifetime&.fire_date,
      pair_fire_dates: male&.lifetimes&.last&.fire_date }
  end

  private

  def create_pair_history!
    pairs.create!(male: male)
  end
end
