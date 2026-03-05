class Api::CategoriesController < ApplicationController
  def index
    categories = Category.order(:name)
    render json: categories
  end

  #--- My Edit 1
  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: {errors: category.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  #--- My Edit 2
  def category_params
    params.require(:category).permit(:name)
  end

end
