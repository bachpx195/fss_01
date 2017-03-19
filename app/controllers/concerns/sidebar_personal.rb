module SidebarPersonal
  private
  def set_sidebar
    @recipes_count = current_user.recipes.all
    @collections = current_user.collections.all
  end
end
