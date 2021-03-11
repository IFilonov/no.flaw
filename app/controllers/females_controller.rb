class FemalesController < ApplicationController
  before_action :authenticate_female!

  def index; end

  def info
    render json: current_female.names
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    current_female.transaction do
      render json: create_male
    end
  rescue StandardError => e
    render json: helpers.log_details(e)
  end

  def update
    render json: current_female.update_pair(pair_params)
  rescue StandardError => e
    render json: helpers.log_details(e)
  end

  def dates
    render json: lifetime_dates
  end

  def set_taboo_date
    lifetime = current_female.lifetimes.create(fire_date: current_female.lifetimes.last&.fire_date,
                                               taboo_date: params[:taboo_dates])
    render json: lifetime ? { created_at: lifetime.created_at } : lifetime.errors.full_messages
  end

  def set_fire_date
    lifetime = current_female.lifetimes.create(taboo_date: current_female.lifetimes.last&.taboo_date,
                                               fire_date: params[:fire_dates])
    render json: lifetime ? { created_at: lifetime.created_at } : lifetime.errors.full_messages
  end

  private

  def pair_params
    params.require(:pair).permit(:username, :password, :nickname)
  end

  def create_male
    current_female.update!(male: Male.create!(pair_params))
    current_female.names
  end

  def lifetime_dates
    lifetime = current_female.lifetimes&.last
    { taboo_dates: lifetime&.taboo_date,
      fire_dates: lifetime&.fire_date,
      pair_fire_dates: current_female.male&.lifetimes&.last&.fire_date }
  end
end
