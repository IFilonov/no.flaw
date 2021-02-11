class Lifetime < ApplicationRecord
  belongs_to :dateable, polymorphic: true
end
