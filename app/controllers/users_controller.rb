class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_by id: params[:id]
    authorize @user
    unless @user

      flash[:danger] = t "errors.user_not_found"
      redirect_to root_path
    end
  end
end
