class Supports::HomePage
  def initialize
    @recipes = Recipe.sort_by_view.published
    @collections = Collection.sort_by_view
    @category_groups = CategoryGroup.all
    @users = User.all
  end

  def recipes
    @recipes.take Settings.frontend.recipes
  end

  def collections
    @collections.take Settings.frontend.collections
  end

  def category_groups
    @category_groups.includes :categories
  end

  def users
    @users.sort_by_recipes.take Settings.frontend.users
  end

  def users_count
    @users.size
  end

  def collections_count
    @collections.size
  end

  def recipes_count
    @recipes.size
  end
end
