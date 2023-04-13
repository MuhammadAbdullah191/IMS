# frozen_string_literal: true

class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  before_action :attach_image, only: [:update]
  before_action :authorize_user

  def index
    @q = Brand.ransack(params[:q])
    @brands = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @brand = Brand.new
  end

  def show; end

  def create
    @brand = Brand.new(brand_params)
    @brand.image.attach(params[:brand][:image])

    if @brand.save
      flash[:success] = 'Brand Created Successfully'
      redirect_to brand_path(@brand)
    else
      flash[:danger] = @brand.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit; end

  def update
    if @brand.update(brand_params)
      flash[:success] = 'Brand Updated Successfully'
      redirect_to brand_path(@brand)
    else
      flash[:danger] = @brand.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    if @brand.destroy
      flash[:success] = 'Brand Deleted successfully'
    else
      flash[:danger] = @brand.errors.full_messages.to_sentence
    end
    
    redirect_to brands_path
  end

  private

  def authorize_user
    authorize Brand
  end

  def set_brand
    @brand = Brand.find_by(id: params[:id])
    return if @brand.present?

    flash[:danger] = 'Brand Record Not Found'
    redirect_to brands_path
  end

  def brand_params
    params.require(:brand).permit(:name, :description, :image)
  end

  def attach_image
    if params[:brand][:image].present?
      @brand.image.attach(params[:brand][:image])
    elsif !@brand.image.attached? && @brand.image.present?
      @brand.image.attach(@brand.image.blob)
    end

  end

end
