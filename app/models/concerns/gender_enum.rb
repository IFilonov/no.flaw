module GenderEnum
  extend ActiveSupport::Concern

  included do
    enum gender: { male: 'male', female: 'female', both: 'both' }, _prefix: :gender,
         _default: :male
  end
end
