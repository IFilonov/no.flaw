class Pair < ApplicationRecord
  belongs_to :male
  belongs_to :female

  validates :female, :male, presence: true

  scope :active, -> { where(divorced_at: nil) }
  scope :history, -> { where.not(divorced_at: nil) }

  def self.active_created
    active.first&.created_at
  end

  def created_at
    self[:created_at].strftime('%H:%M %d.%m.%Y')
  end

  def divorced_at
    self[:divorced_at].strftime('%H:%M %d.%m.%Y')
  end
end
