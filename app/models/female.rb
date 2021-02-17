class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  belongs_to :male, optional: true
  include DeviseDefs
end
