class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end

  def info
    female_name = current_male.pairs.first.female.username if current_male.pairs.first
    render :json => {:name => current_male.username, female_name: female_name }
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end
end
