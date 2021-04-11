class Category < ApplicationRecord
  include GenderEnum
  has_many :gender_tasks

  validates :name, presence: true

  def info
    { label: name, value: id }
  end
end
