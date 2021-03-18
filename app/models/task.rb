class Task < ApplicationRecord
  enum level: { low: 'low', middle: 'middle', high: 'high', none: 'none' }, _suffix: :level,
       _default: 'none'
  enum gender: { male: 'male', female: 'female', none: 'none' }, _prefix: :gender, _default: 'none'
end
