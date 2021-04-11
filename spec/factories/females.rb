FactoryBot.define do
  sequence :username do |n|
    "female#{n}_name"
  end

  factory :female do
    username
    nickname { 'female_nickname' }
    password { '123456789' }
  end
end
