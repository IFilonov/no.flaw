class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end

  def info
    render :json => names
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def create
    begin
      Female.transaction do
        render :json => create_female
      end
    rescue => error
      render :json => helpers.log_details(error)
    end
  end

  def delete
    begin
      current_male.update!(female: nil)
      render :json => names
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

  private
  def female_params
    params.require(:female).permit(:username, :password, :nickname)
  end

  def names(female = nil)
    female ||= current_male.reload.female
    { me: { username: current_male.username },
      pair: { username: female&.username, nickname: female&.nickname }}
  end

  def create_female
    female = Female.create!(female_params)
    current_male.update!(female: female)
    female.pairs.create!(male: current_male)
    names(female)
  end

  def lifetime_dates
    female_lifetime = current_male.female&.lifetimes&.last
    { taboo_dates: female_lifetime&.taboo_date,
      female_fire_dates: female_lifetime&.fire_date,
      fire_dates: current_male.lifetimes&.last&.fire_date }
  end
end
