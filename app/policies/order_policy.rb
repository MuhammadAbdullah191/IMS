class OrderPolicy < ApplicationPolicy

  def index?
    @user.present?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    new?
  end

  def edit?
  end

  def update?
  end

  def destroy?
    @user.Admin?
  end

  def download?
    index?
  end
	
end
