class GenderTasksController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[delete restore]

  def index
    tasks = GenderTask.level(@user.active_pair.level).gender([@user.class.to_s.downcase,
                                                              GenderTask.genders['both']])
    render json: { available: tasks.map(&:info) }
  end

  def create; end
end
