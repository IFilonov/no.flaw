class Male < ApplicationRecord
  has_many :pairs
  has_many :females, through: :pairs
  belongs_to :female, optional: true
  include DeviseDefs
end
