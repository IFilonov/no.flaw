class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  has_many :lifetimes, as: :dateable
  has_many :tasks, as: :userable
  belongs_to :female, optional: true
  include GenderCommon

  def delete_pair!
    update!(female: nil)
  end

  def update_pair!(pair)
    female&.update!(pair)
    info
  end

  def restore_pair!(id)
    update!(female_id: id)
    pairs.create!(female: female)
  end

  def info
    PairInfoPresentor.new(self, female).info
  end

  def pairs_history
    pairs.discarded.includes(:female).order(:id).map(&:female_info)
  end

  def fire_date=(fire_date)
    lifetimes.create!(fire_date: fire_date).created_at
  end

  def lifetime_dates
    LifetimePresentor.new(lifetimes, female&.lifetimes).male_dates
  end
end
