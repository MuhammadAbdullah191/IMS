class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_index_path, flash: { success: 'User Created Successfully' }
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  private
  
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :role)
  end

end
