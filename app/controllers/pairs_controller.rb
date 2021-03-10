class PairsController < ApplicationController
  before_action :authenticate_male! :authenticate_female!


end