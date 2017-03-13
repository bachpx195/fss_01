class Admin::RecipePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    user.admin?
  end
end
