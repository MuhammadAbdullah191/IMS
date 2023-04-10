class SuppliersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  before_action :attach_image, only: [:update]
  before_action :authorize_user

  def index
    @q = Supplier.ransack(params[:q])
    @suppliers = @q.result(distinct: true).all.page(params[:page]).per(6)
  end

  def new
    @supplier = Supplier.new
  end

  def show
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.image.attach(params[:supplier][:image])

    if @supplier.save
      flash[:success] = 'Supplier Created Successfully'
      redirect_to supplier_path(@supplier)
    else
      flash[:danger] = @supplier.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @supplier.update(supplier_params)
      flash[:success] = 'Supplier Updated Successfully'
      redirect_to supplier_path(@supplier)
    else
      flash[:danger] = @supplier.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    
  end

  def destroy
    if @supplier.destroy
      flash[:success] = 'Supplier Deleted successfully'
    else
      flash[:danger] = @supplier.errors.full_messages.to_sentence
    end
      redirect_to suppliers_path
  end

  private

  def authorize_user
    authorize Supplier
  end
  
  def set_supplier
    @supplier = Supplier.find_by_id(params[:id])
    if @supplier.blank?
      flash[:danger] = 'Record Not Found'
      redirect_to suppliers_path
    end

  end

  def supplier_params
    params.require(:supplier).permit(:name, :email, :phone, :address, :image)
  end

  def attach_image
    if params[:supplier][:image].present?
      @supplier.image.attach(params[:supplier][:image])
    elsif !@supplier.image.attached? && @supplier.image.present?
      @supplier.image.attach(@supplier.image.blob)
    end
    
  end

end
