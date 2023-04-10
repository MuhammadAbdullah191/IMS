class OrderItemsController < ApplicationController
  
  def index
    @order_items = OrderItem.all
    @order_items = @order_items.all.page(params[:page]).per(6)
  end

  def show
    @order_item = OrderItem.find_by_id(params[:id])
    if @order_item.blank?
      flash[:danger] = 'Admin Record Not Found'
      redirect_to order_items_path
    end
  end

end
