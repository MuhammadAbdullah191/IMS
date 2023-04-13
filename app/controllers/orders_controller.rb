# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_pdf, only: [:download]
  before_action :set_order, only: %i[show destroy]
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
    @products = @q.result(distinct: true).all.page(params[:page]).per(15)
  end

  def show; end

  def create
    @order = OrderProcessorService.new(product: params[:product]).process_order
    if @order.present?
      session[:cart] = []
      flash[:success] = 'Order was successfully created.'
      redirect_to order_path(@order)
    else
      flash[:danger] = 'Unable to create order please try again'
      redirect_to new_order_path
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
              filename: "order##{@order.id}.pdf",
              type: 'application/pdf')
  end

  private

  def authorize_user
    authorize Order
  end

  def check_params
    params[:q] ||= {}
    return if params[:q][:created_at_lteq].blank?

    params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
  end

  def set_order
    @order = Order.find_by(id: params[:id])
    return if @order.present?

    flash[:danger] = 'Record Not Found'
    redirect_to orders_path
    
  end

  def set_pdf
    @order = Order.find_by(id: params[:id])
    if @order.present?
      @pdf = PdfCreator.new(order: @order).create_pdf
    else
      flash[:danger] = 'Record Not Found'
      redirect_to orders_path
    end

  end

  def check_cart
    return if session[:cart].present?

    flash[:danger] = 'Please select atlease one product to create order'
    redirect_to new_order_path
    nil

  end

  def order_params
    params.require(:order).permit(:product)
  end
end
