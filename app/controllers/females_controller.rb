class FemalesController < ApplicationController
  before_action :authenticate_female!

  def index
  end
end
