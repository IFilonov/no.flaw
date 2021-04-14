class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  has_many :tasks, as: :userable
  has_one :male
  include GenderCommon

  def create_pair!(pair)
    male = Male.create!(pair)
    update!(male: male)
    create_pair_history!
    info
  end

  def delete_pair!
    update!(male: nil)
  end

  def update_pair!(pair)
    male&.update!(pair)
    info
  end

  def restore_pair!(id)
    update!(male: Male.find(id))
    pairs.create!(male: male)
  end

  def info
    PairInfoPresentor.new(self, male).info
  end

  def pairs_history
    pairs.discarded.includes(:male).order(:id).map(&:male_info)
  end

  def lifetime_dates
    LifetimePresentor.new(lifetimes, male&.lifetimes).female_dates
  end
end
