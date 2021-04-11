class ApplicationController < ActionController::Base
  include TransactionHelper
  def index; end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end
