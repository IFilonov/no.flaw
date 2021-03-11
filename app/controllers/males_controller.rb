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
    begin
      female = current_male.female
      female.update!(pair_params) if(female)
      render :json => current_male.names(female)
    rescue => error
      render :json => helpers.log_details(error)
    end
  end

  def dates
    render :json => lifetime_dates
  end

  def set_fire_date
    lifetime = current_male.lifetimes.create( fire_date: params[:fire_dates])
    render :json => lifetime ? { created_at:  lifetime.created_at } : lifetime.errors.full_messages
  end

  def pair_history
    pairs = []
    current_male.pairs.order(:id).each do |pair|
      pairs << {
        username: pair.female.username,
        nickname: pair.female.nickname
      }
    end
    render :json => pairs
  end

  def restore
    current_male.transaction do
      female = Female.find_by!(username: params[:username])
      current_male.update!(female: female)
      render :json => current_male.names(female)
    end
    rescue => error
      render :json => helpers.log_details(error)
  end

  private
  def pair_params
    params.require(:pair).permit(:username, :password, :nickname, :recover)
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
