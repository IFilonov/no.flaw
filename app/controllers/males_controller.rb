class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end

  def info
    render :json => names
  end

  def create
    begin
      Female.transaction do
        female = Female.create!(male_params)
        current_male.update!(female: female)
        female.pairs.create!(male: current_male)
        render :json => { female_name: female.username }
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

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def dates
    female_lifetime = current_male.female&.lifetimes&.last
    render :json => { taboo_dates: female_lifetime&.taboo_date,
                      fire_dates: female_lifetime&.fire_date }
  end

  private
  def male_params
    params.require(:female).permit(:username, :password)
  end

  def names
    female_name = current_male.reload.female&.username
    { name: current_male.username, female_name: female_name }
  end
end
