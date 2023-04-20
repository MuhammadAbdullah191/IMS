# frozen_string_literal: true

class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all.page(params[:page]).per(6)
  end

  def show
    @order_item = OrderItem.find_by(id: params[:id])
    return if @order_item.present?

    flash[:danger] = 'Admin Record Not Found'
    redirect_to order_items_path
  end

end
