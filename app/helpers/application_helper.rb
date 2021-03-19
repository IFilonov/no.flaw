module ApplicationHelper
  def wrap_in_transaction(&block)
    ActiveRecord::Base.transaction(&block)
  rescue => e
    render json: log_details(e)
  end

  def log_details(error)
    { error: "#{controller_name}_controller.#{action_name}".upcase + ": #{error.message}" }
  end
end
