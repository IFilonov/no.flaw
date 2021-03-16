class PairsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[delete restore]

  def delete
    @user.delete_pair!
    render json: @user.info
  end

  def restore
    @user.restore_pair!(params[:username])
    render json: @user.info
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
