class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "header.user_not_found"
      redirect_to root_path
    end
  end
end
