class MalesController < ApplicationController
  before_action :authenticate_male!, except: [:create]
  before_action :authenticate_female!, only: [:create]
  around_action :wrap_in_transaction, only: %i[create update]

  def index; end

  def info
    render json: current_male.info
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def create
    male = Male.create!(male_params)
    current_female.update!(male: male)
    current_female.pairs.create!(male: male)
    render json: current_female.info, status: :created
  end

  def update
    render json: current_male.update_pair!(male_params)
  end

  def dates
    render json: current_male.lifetime_dates
  end

  private

  def male_params
    params.require(:pair).permit(:username, :password, :nickname)
  end
end
