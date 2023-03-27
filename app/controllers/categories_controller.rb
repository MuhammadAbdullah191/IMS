class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = 'Category Created Successfully'
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category Updated Successfully'
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    @category.destroy
    flash[:success] = 'Category Deleted successfully'
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description)
  end
end
