class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  def index
    @admins = Admin.all
    @admins = @admins.all.page(params[:page]).per(6)
  end

  def new
    @admin = Admin.new
  end

  def show
  end

  def create
    @admin = Admin.new(admin_params)
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
    if @admin.destroy
      flash[:success] = 'User Deleted Successfully'
    else
      flash[:danger] = @admin.errors.full_messages.to_sentence
    end
    
    redirect_to admins_path
  end

  private

  def authorize_user
    authorize Admin
  end
  
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :role, :username, :phone)
  end

  def set_admin
    @admin = Admin.find_by_id(params[:id])
    if @admin.blank?
      flash[:danger] = 'Admin Record Not Found'
      redirect_to admins_path
    end
    
  end

end
