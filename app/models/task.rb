class Task < ApplicationRecord
  include LevelEnum
  include GenderEnum

  def info
    { name: name, description: description }
  end
end
