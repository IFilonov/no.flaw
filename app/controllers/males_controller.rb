class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end

  def info
    render :json => current_male.names
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def create
    current_male.transaction do
      render :json => create_female
    end
    rescue => error
      render :json => helpers.log_details(error)
  end

  def update
    render :json => current_male.update_pair(pair_params)
    rescue => error
      render :json => helpers.log_details(error)
  end

  def dates
    render :json => lifetime_dates
  end

  def set_fire_date
    lifetime = current_male.lifetimes.create( fire_date: params[:fire_dates])
    render :json => lifetime ? { created_at:  lifetime.created_at } : lifetime.errors.full_messages
  end

  private
  def pair_params
    params.require(:pair).permit(:username, :password, :nickname)
  end

  def create_female
    female = Female.create!(pair_params)
    current_male.update!(female: female)
    current_male.names(female)
  end

  def lifetime_dates
    female_lifetime = current_male.female&.lifetimes&.last
    { taboo_dates: female_lifetime&.taboo_date,
      pair_fire_dates: female_lifetime&.fire_date,
      fire_dates: current_male.lifetimes&.last&.fire_date }
  end
end
