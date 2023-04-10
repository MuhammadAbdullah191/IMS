class ProductPolicy < ApplicationPolicy

  def index?
    @user.present?
  end

  def show?
    index?
  end

  def new?
    @user.Admin?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
  
  def add_to_cart?
    index?
  end

  def remove_from_cart?
    index?
  end

  def delete_image_attachment?
    index?
  end
	
end