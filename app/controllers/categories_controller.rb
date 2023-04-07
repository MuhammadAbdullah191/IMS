class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true).all.page(params[:page]).per(6)
    authorize @categories
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    @category.image.attach(params[:category][:image])

    if @category.save
      flash[:success] = 'Category Created Successfully'
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

    authorize @category
  end

  def edit
  end

  def update
    @category.image.attach(params[:category][:image])

    if @category.update(category_params)
      flash[:success] = 'Category Updated Successfully'
      redirect_to categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    if @category.destroy
      flash[:success] = 'Category Deleted successfully'
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
    end
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find_by_id(params[:id])
    
    if @category.blank?
      flash[:danger] = 'Category Record Not Found'
      redirect_to categories_path
    else
      authorize Category
    end
    
  end

  def category_params
    params.require(:category).permit(:title, :description, :image)
  end
end
