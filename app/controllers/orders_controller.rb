class OrdersController < ApplicationController

	def index
  end

  def new
    @order = Order.new
    @q = Product.ransack(params[:q])
		@products = @q.result(distinct: true)
  end

end
