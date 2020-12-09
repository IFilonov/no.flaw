class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end

  def user
    render :json => {:user => current_male.username }
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end
end
