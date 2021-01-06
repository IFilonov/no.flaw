class MalesController < ApplicationController
  before_action :authenticate_male!, except: [:create, :delete]
  before_action :authenticate_female!, only: [:create, :delete]

  def index
  end

  def info
    female_name = current_male.pairs.first.female.username if current_male.pairs.first
    render :json => {:name => current_male.username, female_name: female_name }
  end

  def create
    male = Male.new(male_params)
    if male.save
      current_female.pairs.create(male: male)
      current_female.save
      render :json => male
    else
      render :json => male.errors.full_messages
    end
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  private
  def male_params
    params.require(:male).permit(:username, :password)
  end
end
