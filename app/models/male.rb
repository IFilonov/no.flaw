class Male < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :female, optional: true
  include DeviseDefs

  validates :username, presence: true

  def create_pair_history!
    pairs.create!(female: female)
  end

  def delete_pair!
    update!(female: nil)
  end

  def update_pair(pair_params)
    female.update!(pair_params) if female
    names
  end

  def restore!(username)
    update!(female: Female.find_by!(username: username))
  end

  def names(female = nil)
    female ||= reload.female
    { me: { username: username },
      pair: { username: female&.username, nickname: female&.nickname } }
  end

  def pairs_history
    pairs.includes(:female).order(:id).map do |pair|
      { username: pair.female.username,
        nickname: pair.female.nickname }
    end
  end
end
