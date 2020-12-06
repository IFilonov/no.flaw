module Sessions
  extend ActiveSupport::Concern

  included do
    def session_resources
      @user = resource_name.to_s.capitalize.constantize.first
      @resource_names = %w[staff male female] - [resource_name.to_s]
    end
  end
end