module OrderItemsHelper
  def total_orders
    Order.all.count
  end

  def total_orders_price
    OrderItem.all.sum(:price)
  end

  def orders_by_day
    Order.group_by_day(:created_at).count
  end

  def revenue_by_day
    OrderItem.group_by_day(:created_at).sum(:price)
  end

  def top_products_by_revenue
    OrderItem.joins(:product).group('products.name').sum(:price).first(5)
  end

  def top_revenue_products_sum
    top_products_by_revenue.first(5).map { |product| product[1] }.sum
  end

  def quantity_by_product
    OrderItem.joins(:product).group('products.name').sum(:quantity)
  end

end
