class GenderTask < ApplicationRecord
  include LevelEnum
  include GenderEnum

  belongs_to :category
  has_many :tasks

  validates :category, presence: true

  scope :level, ->(level) { where(level: level) }
  scope :gender, ->(gender) { where(gender: gender) }

  def info
    as_json(only: %i[id name description category_id])
  end
end
