class PairsController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[destroy update]

  def index
    render json: @user.pairs_history
  end

  def update
    @user.restore_pair!(params[:username])
    render json: @user.info
  end

  def destroy
    Pair.find(params[:id]).discard
    @user.delete_pair!
    render json: @user.info
  end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end
