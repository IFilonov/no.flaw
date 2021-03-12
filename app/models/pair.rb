class Pair < ApplicationRecord
  belongs_to :male
  belongs_to :female

  validates :female, :male, presence: true
end
