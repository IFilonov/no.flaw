class GenderTasksController < ApplicationController
  before_action :authenticate_user!

  def index
    tasks = GenderTask.level(@user.active_pair.level).gender([@user.class.to_s.downcase,
                                                              GenderTask.genders['both']])
    render json: { available: tasks.map(&:info), issued: @user.planned_tasks }
  end
end
