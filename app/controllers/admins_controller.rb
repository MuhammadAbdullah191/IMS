# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  def index
    @users = Admin.all.page(params[:page]).per(6)
  end

  def new
    @user = Admin.new
  end

  def show; end

  def create
    @user = Admin.new(user_params)
    if @user.save
      flash[:success] = 'User Create Successfully'
      redirect_to admins_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User Updated Successfully'
      redirect_to admins_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    if @user.destroy
      flash[:success] = 'User Deleted Successfully'
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
    end

    redirect_to admins_path
  end

  private

  def authorize_user
    authorize Admin
  end

  def user_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :role, :username, :phone)
  end

  def set_user
    @user = Admin.find_by(id: params[:id])
    return if @user.present?

    flash[:danger] = 'Admin Record Not Found'
    redirect_to admins_path
  end

end
