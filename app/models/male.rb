class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :female, optional: true
  include DeviseDefs

  def create_pair_history!
    pairs.create!(female: female)
  end

  def delete_pair!
    update!(female: nil)
  end

  def create_pair!(pair)
    @female = Female.create!(pair)
    update!(female: @female)
    names
  end

  def update_pair!(pair)
    @female = female
    @female&.update!(pair)
    names
  end

  def restore!(username)
    update!(female: Female.find_by!(username: username))
  end

  def names
    @female ||= reload.female
    { me: { username: username },
      pair: { username: @female&.username, nickname: @female&.nickname } }
  end

  def pairs_history
    pairs.includes(:female).order(:id).map do |pair|
      { username: pair.female.username,
        nickname: pair.female.nickname }
    end
  end

  def set_fire_date(fire_dates)
    lifetime = lifetimes.create!(fire_date: fire_dates)
    { created_at: lifetime.created_at }
  end
end
