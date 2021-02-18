class FemalesController < ApplicationController
  before_action :authenticate_female!

  def index
  end

  def info
    male_name = current_female.male&.username
    render :json => { name: current_female.username, male_name: male_name }
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    begin
      Male.transaction do
        male = Male.create!(female_params.merge(female_id: current_female.id))
        male.pairs.create!(female: current_female)
        render :json => names
      end
    rescue => error
      render :json => helpers.log_details(error)
    end
  end

  def delete
    begin
      current_female.male.update!(female: nil)
      render :json => names
    rescue => error
      render :json => helpers.log_details(error)
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
    params.require(:male).permit(:username, :password)
  end

  def names
    male_name = current_female.reload.male&.username
    { name: current_female.username, male_name: male_name }
  end
end
