class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    authorize @products
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Product Created Successfully'
      redirect_to products_path
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product Updated Successfully'
      redirect_to products_path
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
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
    unless session[:cart].include?(id)
      session[:cart] << id
    end

    render partial: 'orders/cart_row', locals: { product: Product.find(id) }
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    render partial: 'orders/product_row', locals: { product: Product.find(id) }
  end


  private
  
  def set_product
    @product = Product.find_by_id(params[:id])
    if @product.blank?
      flash[:danger] = 'Record Not Found'
      redirect_to products_path
    end
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :stock, :description, :price, :location_name, :brand_id, :category_id, :supplier_id)
  end
  
end
