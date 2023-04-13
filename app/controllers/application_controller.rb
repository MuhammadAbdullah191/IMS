# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :initialize_session
  before_action :load_cart

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def route_not_found
    flash[:danger] = 'This route does not exist'
    redirect_back(fallback_location: root_path)
  end

  private

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    flash[:danger] = 'This record is not found'
    redirect_back(fallback_location: root_path)
  end

  def pundit_user
    current_admin
  end

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Product.find(session[:cart])
    @cart ||= []
  end

end
