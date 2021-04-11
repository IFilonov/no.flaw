class Task < ApplicationRecord
  belongs_to :userable, polymorphic: true
  belongs_to :gender_task
  attribute :planned_time, :date, default: Date.today + 3

  validates :planned_time, :gender_task, :userable, presence: true

  def planned
    as_json(only: %i[id planned_time], include: { gender_task: { only: :name } })
  end
end
