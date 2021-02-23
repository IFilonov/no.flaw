class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  has_many :lifetimes, as: :dateable
  has_one :male
  include DeviseDefs
end
