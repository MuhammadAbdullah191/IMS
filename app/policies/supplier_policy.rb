class SupplierPolicy < ApplicationPolicy

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
	
end