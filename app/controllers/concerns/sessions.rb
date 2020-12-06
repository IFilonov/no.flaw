module Sessions
  extend ActiveSupport::Concern

  included do
    def session_resources
      @resource_names = ["staff", "male", "female"] - [resource_name.to_s]
    end
  end
end