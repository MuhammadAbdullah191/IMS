class OrdersController < ApplicationController
  before_action :set_pdf, only: [:download, :preview]
  before_action :set_order, only: [:show, :destroy]
  before_action :authorize_user
  
  def index
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @order = Order.new
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
  end

  def create
    if session[:cart].empty?
      flash[:danger] = 'Please select atlease one product to create order'
      redirect_to new_order_path
      return
    end
    @order = Order.new
    ActiveRecord::Base.transaction do
      begin
        ensure_valid_products!
        @order.save!
        process_products!
        session[:cart] = []
        flash[:success] = 'Order was successfully created.'
        redirect_to new_order_path
      rescue ArgumentError => e
        flash[:danger] = e.message
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = 'Order Deleted successfully'
    else
      flash[:danger] = @order.errors.full_messages.to_sentence
    end

      redirect_to orders_path
  end

  def download
    send_data(@pdf.render,
      filename: 'hello.pdf',
      type: 'application/pdf'
    )
  end

  def preview
    send_data(@pdf.render,
      filename: 'hello.pdf',
      type: 'application/pdf',
      disposition: 'inline'
    )
  end
  
  private

  def authorize_user
    authorize Order
  end

  def set_order
    @order = Order.find_by_id(params[:id])
    if @order.blank?
      flash[:danger] = 'Record Not Found'
      redirect_to orders_path
    end
  end

  def set_pdf
    @order = Order.find_by_id(params[:id])
    @pdf = PdfCreator.new(params[:id]).create_pdf
  end

  def calculate_total_price(products)
    total_price = 0
    products.each do |product_id, quantity|
      product = Product.find_by_id(product_id)
      total_price += product.price * quantity.to_i
    end

    total_price
  end

  def order_params
    params.require(:order).permit(:product)
  end

  def ensure_valid_products!
    raise ArgumentError.new("No products specified") unless params[:product].present?
    params[:product].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      raise ArgumentError.new("Invalid product ID: #{product_id}") unless product.present?
      raise ArgumentError.new("Invalid quantity for product #{product_id}: #{quantity}") unless quantity.present? && quantity.to_i > 0
      raise ArgumentError.new("Insufficient stock for product #{product_id}") if product.stock.to_i < quantity.to_i
    end
  end

  def process_products!
    params[:product].each do |product_id, quantity|
      product = Product.find_by_id(product_id)
      @order.order_items.create(
        product_id: product_id,
        description: product.name,
        quantity: quantity,
        price: quantity.to_i * product.price
      )
      product.stock -= quantity.to_i
      product.save!
    end
  end

end
