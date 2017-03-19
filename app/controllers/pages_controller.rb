class PagesController < ApplicationController
  def show
    @recipes = Recipe.sort_by_view.published.take 6
    @collections = Collection.sort_by_view.take 5
    @category_groups = CategoryGroup.all.includes(:categories)
    @users = User.sort_by_recipes.take 4
    @user_all = User.all.count
    @collection_all = Collection.all.count
    @recipe_all = Recipe.all.count
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    url = Rails.root + "app/views/pages/#{params[:page]}.html.erb"
    File.exist? Pathname.new(url)
  end
end
