class FemalesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_female!
  around_action :wrap_in_transaction, only: %i[create update set_taboo_date set_fire_date]

  def index; end

  def info
    render json: current_female.names
  end

  def logout
    sign_out current_female
    redirect_to new_female_session_path
  end

  def create
    render json: current_female.create_pair!(pair_params)
  end

  def update
    render json: current_female.update_pair!(pair_params)
  end

  def dates
    render json: current_female.lifetime_dates
  end

  def set_taboo_date
    render json: current_female.set_taboo_date(params[:taboo_dates])
  end

  def set_fire_date
    render json: current_female.set_fire_date(params[:fire_dates])
  end

  private

  def pair_params
    params.require(:pair).permit(:username, :password, :nickname)
  end
end
