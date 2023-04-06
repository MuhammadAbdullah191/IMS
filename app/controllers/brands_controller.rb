class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  def index
    @q = Brand.ransack(params[:q])
    @brands = @q.result(distinct: true)
    authorize @brands
  end

  def new
    @brand = Brand.new
  end

  def show
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      flash[:success] = 'Brand Created Successfully'
      redirect_to brands_path
    else
      flash[:danger] = @brand.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    authorize @brand
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      flash[:success] = 'Brand Updated Successfully'
      redirect_to brands_path
    else
      flash[:danger] = @brand.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
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

  def set_brand
    @brand = Brand.find_by_id(params[:id])
    if @brand.blank?
      flash[:danger] = 'Brand Record Not Found'
      redirect_to brands_path
    end
    authorize @brand
  end

  def brand_params
    params.require(:brand).permit(:name, :description)
  end

end
