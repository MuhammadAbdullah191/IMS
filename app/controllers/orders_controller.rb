class OrdersController < ApplicationController

	def index
		@products = Product.all
	end

end
