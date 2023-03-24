class SuppliersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_supplier, only: [:edit, :update, :destroy]

  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      flash[:success] = 'Supplier Created Successfully'
      redirect_to suppliers_path
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
      redirect_to suppliers_path
    else
      flash[:danger] = @supplier.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
    
  end

  def destroy
    @supplier.destroy
    flash[:success] = 'Supplier Deleted successfully'
    redirect_to suppliers_path
  end

  private
  
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:name, :email, :phone, :address)
  end


end
