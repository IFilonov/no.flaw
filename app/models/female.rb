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

  def restore!(username)
    update!(male: Male.find_by!(username: username))
  end

  def names(male = nil)
    male ||= reload.male
    { me: { username: username },
      pair: { username: male&.username, nickname: male&.nickname }}
  end
end
