module TransactionHelper
  def wrap_in_transaction(&block)
    ActiveRecord::Base.transaction(&block)
  rescue StandardError => e
    render json: log_details(e), status: :bad_request
  end

  def log_details(error)
    { error: "#{controller_name}_controller.#{action_name}".upcase + ": #{error.message}" }
  end
end
