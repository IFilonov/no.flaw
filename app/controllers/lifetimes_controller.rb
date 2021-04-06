class LifetimesController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[set_taboo_date set_fire_date]

  def set_taboo_date
    render json: @user.set_taboo_date(params[:taboo_date])
  end

  def set_fire_date
    render json: @user.set_fire_date(params[:fire_date])
  end
end
