class Category < ApplicationRecord
  include GenderEnum
  has_many :gender_tasks

  def info
    { label: name, value: id }
  end
end
