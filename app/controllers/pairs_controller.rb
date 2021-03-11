class PairsController < ApplicationController
  before_action :authenticate_user!

  def delete
    @user.transaction do
      @user.create_pair_history!
      @user.delete_pair!
      render json: @user.names
    end
  rescue StandardError => e
    render json: helpers.log_details(e)
  end

  def restore
    @user.transaction do
      @user.restore!(params[:username])
      render json: @user.names
    end
  rescue StandardError => e
    render json: helpers.log_details(e)
  end

  def history
    render json: @user.pairs_history
  end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end
