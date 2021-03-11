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

  def names(female = nil)
    female ||= reload.female
    { me: { username: username },
      pair: { username: female&.username, nickname: female&.nickname }}
  end
end
