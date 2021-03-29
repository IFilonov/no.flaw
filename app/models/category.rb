class Category < ApplicationRecord
  include GenderEnum
  has_many :tasks
end
