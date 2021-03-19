module LevelEnum
  extend ActiveSupport::Concern

  included do
    enum level: { low: 'low', middle: 'middle', high: 'high', none: 'none' }, _suffix: :level,
         _default: :low
  end
end
