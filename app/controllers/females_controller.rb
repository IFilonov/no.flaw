class FemalesController < ApplicationController
  before_action :authenticate_female!, except: [:create, :delete]
  before_action :authenticate_male!, only: [:create, :delete]

  def index
  end

  def info
    male_name = current_female.pairs.first.male.username if current_female.pairs.first
    render :json => { name: current_female.username, male_name: male_name }
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    female = Female.new(female_params)
    if female.save
      current_male.pairs.create(female: female)
      current_male.save
      render :json => female
    else
      render :json => female.errors.full_messages
    end
  end

  def delete
    current_male.pairs.first.delete
    render :json => { count: current_male.pairs.count }
  end

  def taboo_dates
    render :json => { taboo_dates: current_female.lifetimes.last&.taboo_date }
  end

  def set_taboo_dates
    Lifetime.create( taboo_date: params[:taboo_dates], dateable: current_female)
  end

  private
  def female_params
    params.require(:female).permit(:username, :password)
  end
end
