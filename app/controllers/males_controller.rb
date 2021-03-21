class MalesController < ApplicationController
  include TransactionHelper
  before_action :authenticate_male!
  around_action :wrap_in_transaction, only: %i[create update set_fire_date]

  def index; end

  def info
    render json: current_male.info
  end

  def logout
    sign_out current_male
    redirect_to new_male_session_path
  end

  def create
    render json: current_male.create_pair!(pair_params)
  end

  def update
    render json: current_male.update_pair!(pair_params)
  end

  def dates
    render json: current_male.lifetime_dates
  end

  private

  def pair_params
    params.require(:pair).permit(:username, :password, :nickname)
  end
end
