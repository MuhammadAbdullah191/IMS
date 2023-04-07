class OrderItemsController < ApplicationController
  
  def index
    @order_items = OrderItem.all
    @order_items = @order_items.all.page(params[:page]).per(6)
  end

  def show
    @order_item = OrderItem.find(params[:id])
  end

end
