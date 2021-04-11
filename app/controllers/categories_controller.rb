class CategoriesController < ApplicationController
  def index
    render json: Category.all.map(&:info)
  end
end
