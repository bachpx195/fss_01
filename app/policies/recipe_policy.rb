class RecipePolicy < ApplicationPolicy
  def show?
    if @record.published?
      true
    elsif user.nil?
      false
    elsif  user_is_owner_of_record? || user.admin?
      true
    else
      false
    end
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private
  def user_is_owner_of_record?
    @user == @record.user
  end
end
