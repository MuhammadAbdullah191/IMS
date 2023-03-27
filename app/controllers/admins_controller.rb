class AdminsController < ApplicationController
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
      flash[:success] = 'User Create Successfully'
      redirect_to admins_path
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      flash[:success] = 'User Updated Successfully'
      redirect_to admins_path
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    
  end

  def destroy
    @admin.destroy
    flash[:success] = 'User Deleted Successfully'
    redirect_to admins_path
  end

  def dashboard
  end

  private
  
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :role, :username, :phone)
  end

  def set_admin
    @admin = Admin.find(params[:id])
    authorize @admin
  end

end
