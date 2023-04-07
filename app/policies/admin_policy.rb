class AdminPolicy < ApplicationPolicy

	def index?
		@user.Admin?
	end

	def new?
    index?
	end

	def show?
		index?
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