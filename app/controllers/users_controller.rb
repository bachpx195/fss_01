class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def show
    @recipes = @user.recipes.published
    @collections = @user.collections
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "errors.user_not_found"
      redirect_to root_path
    end
  end
end
