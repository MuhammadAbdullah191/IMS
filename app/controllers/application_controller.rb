class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  
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
	
end
