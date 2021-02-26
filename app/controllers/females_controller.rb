class FemalesController < ApplicationController
  before_action :authenticate_female!

  def index
  end

  def info
    render :json => names
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    begin
      Male.transaction do
        male = Male.create!(male_params.merge(female_id: current_female.id))
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
    render :json => lifetime_dates
  end

  def set_taboo_date
    lifetime = current_female.lifetimes.create(fire_date: current_female.lifetimes.last&.fire_date,
                                               taboo_date: params[:taboo_dates])
    render :json => lifetime ? { created_at:  lifetime.created_at } : lifetime.errors.full_messages
  end

  def set_fire_date
    lifetime = current_female.lifetimes.create( taboo_date: current_female.lifetimes.last&.taboo_date,
                                                fire_date: params[:fire_dates])
    render :json => lifetime ? { created_at:  lifetime.created_at } : lifetime.errors.full_messages
  end

  private
  def male_params
    params.require(:male).permit(:username, :password, :nickname)
  end

  def names
    male = current_female.reload.male
    { name: current_female.username, male_name: male&.username, nickname: male&.nickname }
  end

  def lifetime_dates
    lifetime = current_female.lifetimes&.last
    { taboo_dates: lifetime&.taboo_date,
      fire_dates: lifetime&.fire_date,
      male_fire_dates: current_female.male&.lifetimes&.last&.fire_date
    }
  end

end
