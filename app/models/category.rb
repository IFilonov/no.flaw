class Category < ApplicationRecord
  include GenderEnum
  has_many :tasks

  def info
    { label: name, value: id}
  end
end
