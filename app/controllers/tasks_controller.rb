class TasksController < ApplicationController
  before_action :authenticate_user!
  around_action :wrap_in_transaction, only: %i[delete restore]

  def index
    tasks = Task.level(@user.active_pair.level).gender([@user.class.to_s.downcase,
                                                        Task.genders['both']])
    render json: { available: tasks.map(&:info) }
  end

  private

  def authenticate_user!
    current_male ? :authenticate_male! : :authenticate_female!
    @user = current_male || current_female
  end
end
