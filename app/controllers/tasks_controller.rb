class TasksController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[create]

  def create
    @user.tasks.create!(gender_task_id: params[:id])
    render json: @user.planned_tasks
  end
end
