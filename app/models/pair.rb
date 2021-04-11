class Pair < ApplicationRecord
  belongs_to :male
  belongs_to :female
  include Discard::Model
  include LevelEnum

  self.discard_column = :divorced_at

  validates :female, :male, presence: true

  def self.active
    kept.first
  end

  def created_at
    self[:created_at].strftime('%d.%m.%Y %H:%M')
  end

  def male_info
    { username: male.username,
      nickname: male.nickname,
      created_at: created_at,
      divorced_at: divorced_at,
      id: male.id }
  end

  def female_info
    { username: female.username,
      nickname: female.nickname,
      created_at: created_at,
      divorced_at: divorced_at,
      id: female.id }
  end

  private

  def divorced_at
    self[:divorced_at]&.strftime('%d.%m.%Y %H:%M')
  end
end
