# frozen_string_literal: true

class OrderProcessorService
  def initialize(order_params)
    @order_params = order_params
  end

  def process_order
    @order = Order.new
    ActiveRecord::Base.transaction do
      ensure_valid_products!
      @order.save!
      process_products!
      return @order
    rescue ArgumentError => e
      raise ActiveRecord::Rollback
    rescue => e
      raise ActiveRecord::Rollback
    end
  end

  private

  def ensure_valid_products!
    raise ArgumentError, 'No products specified' if @order_params[:product].blank?

    @order_params[:product].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      raise ArgumentError, "Invalid product ID: #{product_id}" if product.blank?
      raise ArgumentError, "Insufficient stock for product #{product_id}" if product.stock.to_i < quantity.to_i
    end
  end

  def process_products!
    @order_params[:product].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
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
