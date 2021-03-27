class TasksController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[delete restore]

  def index
    tasks = Task.where(level: @user.active_pair.level, gender: @user.class.to_s.downcase)
    tasks_arr = []
    tasks.map do |task|
      tasks_arr << task.info
    end
    render json: { available: tasks_arr }
  end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end
