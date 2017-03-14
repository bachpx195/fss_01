class Admin::UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def home?
    user.admin?
  end
end
