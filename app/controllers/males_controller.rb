class MalesController < ApplicationController
  before_action :authenticate_male!
  around_action :wrap_in_transaction, only: %i[create update set_fire_date]

  def index; end

  def info
    render json: current_male.names
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def create
    render json: current_male.create_pair!(pair_params)
  end

  def update
    render json: current_male.update_pair!(pair_params)
  end

  def dates
    render json: lifetime_dates
  end

  def set_fire_date
    render json: current_male.set_fire_date(params[:fire_dates])
  end

  private

  def pair_params
    params.require(:pair).permit(:username, :password, :nickname)
  end

  def lifetime_dates
    female_lifetime = current_male.female&.lifetimes&.last
    { taboo_dates: female_lifetime&.taboo_date,
      pair_fire_dates: female_lifetime&.fire_date,
      fire_dates: current_male.lifetimes&.last&.fire_date }
  end

  def wrap_in_transaction(&block)
    ActiveRecord::Base.transaction(&block)
  rescue StandardError => e
    render json: helpers.log_details(e)
  end
end
