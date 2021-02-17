class FemalesController < ApplicationController
  before_action :authenticate_female!, except: [:create, :delete]
  before_action :authenticate_male!, only: [:create, :delete]

  def index
  end

  def info
    male_name = current_female.male.present? ? current_female.male.username : ''
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
    begin
      current_male.female.male_id = nil
      current_male.female.save!
      current_male.female_id = nil
      current_male.save!
      render :json => {}
    rescue => error
      render :json => { error: error.inspect }
    end
  end

  def dates
    render :json => { taboo_dates: current_female.lifetimes.last&.taboo_date, fire_dates: current_female.lifetimes.last&.fire_date }
  end

  def set_taboo_date
    lifetime = Lifetime.create( fire_date: current_female.lifetimes.last&.fire_date, taboo_date: params[:taboo_dates], dateable: current_female)
    if lifetime
      render :json => { created_at:  current_female.lifetimes.last.created_at }
    else
      render :json => lifetime.errors.full_messages
    end
  end

  def set_fire_date
    lifetime = Lifetime.create( taboo_date: current_female.lifetimes.last&.taboo_date, fire_date: params[:fire_dates], dateable: current_female)
    if lifetime
      render :json => { created_at:  current_female.lifetimes.last.created_at }
    else
      render :json => lifetime.errors.full_messages
    end
  end

  private
  def female_params
    params.require(:female).permit(:username, :password)
  end
end
