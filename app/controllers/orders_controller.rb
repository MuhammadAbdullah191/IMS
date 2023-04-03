class OrdersController < ApplicationController
  before_action :set_pdf, only: [:download, :preview]

	def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @q = Product.ransack(params[:q])
		@products = @q.result(distinct: true)
  end

  def show
    @order = Order.find(params[:id])
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

  def set_pdf
    @order = Order.find_by_id(params[:id])
    @pdf = PdfCreator.new(params[:id]).create_pdf
  end

  def calculate_total_price(products)
    total_price = 0
    products.each do |product_id, quantity|
      product = Product.find(product_id)
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
      product = Product.find(product_id)
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
