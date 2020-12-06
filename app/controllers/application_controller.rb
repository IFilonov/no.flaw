class ApplicationController < ActionController::Base
  before_action :authenticate_staff!

  def index
  end
end

