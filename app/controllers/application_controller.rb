class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :initialize_session
  before_action :load_cart

	include Pundit::Authorization

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
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
