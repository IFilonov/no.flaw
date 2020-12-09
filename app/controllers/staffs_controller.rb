class StaffsController < ApplicationController
  before_action :authenticate_staff!

  def index
  end

  def user
    render :json => {:user => current_staff.email }
  end

  def logout
    sign_out current_staff
    redirect_to new_staff_session_path
  end
end
