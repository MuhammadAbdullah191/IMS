class SuppliersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @suppliers = Supplier.all
    authorize @suppliers
  end

  def new
    @supplier = Supplier.new
  end

  def show
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

    authorize @supplier
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
    if @supplier.destroy
      flash[:success] = 'Supplier Deleted successfully'
    else
      flash[:danger] = @supplier.errors.full_messages.to_sentence
    end
      redirect_to suppliers_path
  end

  private
  
  def set_supplier
    @supplier = Supplier.find_by_id(params[:id])
    if @supplier.blank?
      flash[:danger] = 'Record Not Found'
      redirect_to suppliers_path
    end

    authorize @supplier
  end

  def supplier_params
    params.require(:supplier).permit(:name, :email, :phone, :address)
  end


end
