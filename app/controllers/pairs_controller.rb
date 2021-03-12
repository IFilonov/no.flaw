class PairsController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[delete restore]

  def delete
    @user.create_pair_history!
    @user.delete_pair!
    render json: @user.names
  end

  def restore
    @user.restore_pair!(params[:username])
    render json: @user.names
  end

  def history
    render json: @user.pairs_history
  end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end

  def wrap_in_transaction(&block)
    ActiveRecord::Base.transaction(&block)
  rescue StandardError => e
    render json: helpers.log_details(e)
  end
end
