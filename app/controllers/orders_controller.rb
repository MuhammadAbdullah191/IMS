class OrdersController < ApplicationController
  before_action :set_pdf, only: [:download, :preview]
  before_action :set_order, only: [:show, :destroy]
  before_action :check_cart, only: [:create]
  before_action :check_params, only: [:create]
  before_action :authorize_user
  
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @order = Order.new
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def show
  end

  def create
    @order = OrderProcessorService.new(params).process_order
    if @order.present?
      session[:cart] = []
      flash[:success] = 'Order was successfully created.'
      redirect_to preview_order_path(@order)
    else
      flash[:danger] = 'Unable to create order please try again'
      render :new, status: :unprocessable_entity
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

  def check_params
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
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

  def check_cart
    if session[:cart].empty?
      flash[:danger] = 'Please select atlease one product to create order'
      redirect_to new_order_path
      return
    end
  end

  def order_params
    params.require(:order).permit(:product)
  end

end
