# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :attach_image, only: [:update]
  before_action :authorize_user

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @category = Category.new
  end

  def show; end

  def create
    @category = Category.new(category_params)
    @category.image.attach(params[:category][:image])

    if @category.save
      flash[:success] = 'Category Created Successfully'
      redirect_to category_path(@category)
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category Updated Successfully'
      redirect_to category_path(@category)
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
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

  def authorize_user
    authorize Category
  end

  def set_category
    @category = Category.find_by(id: params[:id])

    return if @category.present?

    flash[:danger] = 'Category Record Not Found'
    redirect_to categories_path
    
  end

  def category_params
    params.require(:category).permit(:name, :description, :image)
  end

  def attach_image
    if params[:category][:image].present?
      @category.image.attach(params[:category][:image])
    elsif !@category.image.attached? && @category.image.present?
      @category.image.attach(@category.image.blob)
    end
    
  end

end
