class PairsController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[destroy update]

  def index
    render json: @user.pairs_history
  end

  def update
    @user.restore_pair!(params[:id])
    render json: @user.info
  end

  def destroy
    Pair.find(params[:id]).discard
    @user.delete_pair!
    head :no_content
  end
end
