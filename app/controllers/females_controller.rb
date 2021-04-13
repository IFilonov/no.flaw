class FemalesController < ApplicationController
  before_action :authenticate_female!, except: [:create]
  before_action :authenticate_male!, only: [:create]
  around_action :wrap_in_transaction, only: %i[create update set_taboo_date set_fire_date]

  def index; end

  def info
    render json: current_female.info
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    female = Female.create!(female_params)
    current_male.update!(female: female)
    current_male.pairs.create!(female: female)
    render json: current_male.info, status: :created
  end

  def update
    render json: current_female.update_pair!(female_params)
  end

  def dates
    render json: current_female.lifetime_dates
  end

  private

  def female_params
    params.require(:pair).permit(:username, :password, :nickname)
  end
end
