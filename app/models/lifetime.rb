class Lifetime < ApplicationRecord
  belongs_to :dateable, polymorphic: true

  validates :dateable, presence: true
end
