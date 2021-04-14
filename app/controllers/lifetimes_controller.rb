class LifetimesController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[create]

  def create
    lifetimes = @user.lifetimes
    lifetime_as_hash = lifetimes.last.as_json(only: %i[taboo_date
                                                       fire_date])&.with_indifferent_access.to_h
    lifetime = lifetimes.create!(lifetime_as_hash.merge(life_time_params))
    render json: lifetime.created_at, status: :created
  end

  private

  def life_time_params
    params.permit(:fire_date, :taboo_date)
  end
end
