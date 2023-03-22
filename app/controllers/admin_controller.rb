class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all
    authorize @admins
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(admin_params)
    authorize @admin

    if @admin.save
      redirect_to admin_index_path, flash: { success: 'User Created Successfully' }
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @admin.save
      redirect_to admin_index_path, flash: { success: 'User Created Successfully' }
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    
  end

  def destroy
    @admin.destroy
    redirect_to admin_index_path, flash: { success: 'Admin Deleted successfully' }
  end

  def dashboard
  end

  private
  
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :role)
  end

  def set_admin
    @admin = Admin.find(params[:id])
    authorize @admin
  end

end
