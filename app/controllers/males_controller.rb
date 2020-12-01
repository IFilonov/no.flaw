class MalesController < ApplicationController
  before_action :authenticate_male!

  def index
  end
end
