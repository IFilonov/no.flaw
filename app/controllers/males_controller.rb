class MalesController < ApplicationController
  before_action :authenticate_male!, except: [:create, :delete]
  before_action :authenticate_female!, only: [:create, :delete]

  def index
  end

  def info
    female_name = current_male.pairs.includes(:female).order(id: :desc).pluck(:username).last
    render :json => { name: current_male.username, female_name: female_name }
  end

  def create
    male = Male.new(male_params)
    if male.save
      current_female.pairs.create(male: male)
      current_female.save
      render :json => male
    else
      render :json => male.errors.full_messages
    end
  end

  def delete
    current_female.pairs.first.delete
    render :json => { count: current_female.pairs.count }
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def dates
    render :json => { taboo_dates: "[]",#current_male.pairs.last.female.lifetimes.last&.taboo_date,
                      fire_dates: "{}" } # current_male.pairs.last.female.lifetimes.last&.fire_date }
  end

  private
  def male_params
    params.require(:male).permit(:username, :password)
  end
end
