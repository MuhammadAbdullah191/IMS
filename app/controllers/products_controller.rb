# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :attach_image, only: [:update]
  before_action :authorize_user

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = Product.new(product_params)
    @product.image.attach(params[:product][:image])

    if @product.save
      flash[:success] = 'Product Created Successfully'
      redirect_to product_path(@product)
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product Updated Successfully'
      redirect_to product_path(@product)
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    if @product.destroy
      flash[:success] = 'Product Deleted successfully'
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
    end
    
    redirect_to products_path
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)

    render partial: 'orders/cart_row', locals: { product: Product.find_by(id: id) }
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    render partial: 'orders/product_row', locals: { product: Product.find_by(id: id) }
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find_by(id: params[:id])
    @image.purge
    redirect_to request.referer
  end

  private

  def authorize_user
    authorize Product
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product.present?

    flash[:danger] = 'Record Not Found'
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:name, :stock, :description, :price, :location_name, :brand_id, supplier_ids: [], category_ids: [])
  end

  def attach_image
    if params[:product][:image].present?
      @product.image.attach(params[:product][:image])
    elsif !@product.image.attached? && @product.image.present?
      @product.image.attach(@product.image.blob)
    end

  end
  
end
