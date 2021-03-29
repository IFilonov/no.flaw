class Task < ApplicationRecord
  belongs_to :category
  include LevelEnum
  include GenderEnum

  def info
    { name: name, description: description }
  end
end
