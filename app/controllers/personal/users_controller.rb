class Personal::UsersController < PersonalController
  def show
    @recipes_count = current_user.recipes.count
    @collections_count = current_user.collections.count
  end

  def edit
  end

  def update
    if current_user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to personal_root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :description, :avatar, :avatar_cache,
      :country
  end
end
