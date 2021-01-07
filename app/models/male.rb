class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  include DeviseDefs
end
