class PairsController < ApplicationController
  before_action :authenticate_user!

  def delete
    @user.transaction do
      @user.create_pair_history!
      @user.delete_pair!
      render :json => @user.names
    end
  rescue => error
    render :json => helpers.log_details(error)
  end

  def restore
    @user.transaction do
      @user.restore!(params[:username])
      render :json => @user.names
    end
    rescue => error
      render :json => helpers.log_details(error)
  end

  private
  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end