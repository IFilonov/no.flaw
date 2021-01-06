class Female < ApplicationRecord
  has_many :pairs
  has_many :males, through: :pairs
  include DeviseDefs
end
