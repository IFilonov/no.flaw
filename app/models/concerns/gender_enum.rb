module GenderEnum
  extend ActiveSupport::Concern

  included do
    enum gender: { male: 'male', female: 'female', none: 'none' }, _prefix: :gender,
         _default: :male
  end
end
