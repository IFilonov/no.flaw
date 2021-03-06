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

  def update
    begin
      female = current_male.female
      female.update!(pair_params) if(female)
      render :json => names(female)
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

  private
  def pair_params
    params.require(:pair).permit(:username, :password, :nickname, :recover)
  end

  def names(female = nil)
    female ||= current_male.reload.female
    { me: { username: current_male.username },
      pair: { username: female&.username, nickname: female&.nickname }}
  end

  def create_female
    if(pair_params["recover"])
      female = Female.find_by!(username: pair_params["username"])
    else
      female = Female.create!(pair_params)
      female.pairs.create!(male: current_male)
    end
    current_male.update!(female: female)
    names(female)
  end

  def lifetime_dates
    female_lifetime = current_male.female&.lifetimes&.last
    { taboo_dates: female_lifetime&.taboo_date,
      pair_fire_dates: female_lifetime&.fire_date,
      fire_dates: current_male.lifetimes&.last&.fire_date }
  end
end
