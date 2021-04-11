class Lifetime < ApplicationRecord
  belongs_to :dateable, polymorphic: true

  validates :dateable, presence: true

  def created_at
    { created_at: self[:created_at].strftime('%H:%M %d.%m.%Y') }
  end
end
