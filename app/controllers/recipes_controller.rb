class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show]

  def show
  end

  private

  def find_recipe
    @recipe = Recipe.find_by id: params[:id]
    unless @recipe
      flash[:danger] = t "errors.recipe_not_found"
      redirect_to root_url
    end
  end
end
