class OrderProcessorService
  attr_reader :order_params

  def initialize(order_params)
    @order_params = order_params
  end

  def process_order
    @order = Order.new
    ActiveRecord::Base.transaction do
    begin
      ensure_valid_products!
      @order.save!
      process_products!
      return @order
      rescue ArgumentError => e
        raise ActiveRecord::Rollback
      end
    end
    
  end

  private

  def ensure_valid_products!
    raise ArgumentError.new("No products specified") unless @order_params[:product].present?
    @order_params[:product].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      raise ArgumentError.new("Invalid product ID: #{product_id}") unless product.present?
      raise ArgumentError.new("Insufficient stock for product #{product_id}") if product.stock.to_i < quantity.to_i
    end
  end

  def process_products!
    @order_params[:product].each do |product_id, quantity|
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
