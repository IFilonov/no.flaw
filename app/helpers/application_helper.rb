module ApplicationHelper
  def log_details(error)
    { error: "#{controller_name}_controller.#{action_name}".upcase + ": #{error.message}" }
  end
end
