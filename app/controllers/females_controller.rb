class FemalesController < ApplicationController
  before_action :authenticate_female!

  def index
  end

  def user
    render :json => {:user => current_female.username }
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end
end
