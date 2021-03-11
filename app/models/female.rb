class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  has_one :male
  include DeviseDefs

  def create_pair_history!
    pairs.create!(male: male)
  end

  def delete_pair!
    update!(male: nil)
  end

  def update_pair(pair_params)
    male.update!(pair_params) if male
    names
  end

  def restore!(username)
    update!(male: Male.find_by!(username: username))
  end

  def names
    male ||= reload.male
    { me: { username: username },
      pair: { username: male&.username, nickname: male&.nickname } }
  end

  def pairs_history
    pairs.includes(:male).order(:id).map do |pair|
      { username: pair.male.username,
        nickname: pair.male.nickname }
    end
  end
end
