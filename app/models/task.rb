class Task < ApplicationRecord
  belongs_to :category
  include LevelEnum
  include GenderEnum

  scope :level, ->(level) { where(level: level) }
  scope :gender, ->(gender) { where(gender: gender) }

  def info
    { id: id, name: name, description: description, category_id: category_id }
  end
end
