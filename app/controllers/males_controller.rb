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
    begin
      Male.transaction do
        male = Male.create!(male_params.merge(female_id: current_female.id))
        Pair.create!(male_id: male.id, female_id: current_female.id)
        current_female.male_id = male.id
        current_female.save!
        render :json => { male_name: male.username }
      end
    rescue => error
      render :json => { error: error.inspect }
    end
  end

  def delete
    begin
      current_female.transaction do
        current_female.male.female_id = nil
        current_female.male.save!
        current_female.male_id = nil
        current_female.save!
        render :json => {}
      end
    rescue => error
      render :json => { error: error.inspect }
    end
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def dates
    female_lifetime = current_male.pairs.last.female.lifetimes.last
    render :json => { taboo_dates: female_lifetime&.taboo_date,
                      fire_dates: female_lifetime&.fire_date }
  end

  private
  def male_params
    params.require(:male).permit(:username, :password)
  end
end
