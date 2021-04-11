FactoryBot.define do
  factory :task do
    planned_time { '2021-04-10' }
    started_time { '2021-04-10' }
    finished_time { '2021-04-10' }
    references { '' }
  end
end
