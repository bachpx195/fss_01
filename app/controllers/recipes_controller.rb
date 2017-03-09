class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show]

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.steps.build
    @recipe.materials.build
  end

  def create
    @recipe = current_user.recipes.build recipe_params
    if @recipe.save
      flash[:notice] = t "recipe.success"
      redirect_to @recipe
    else
      render :new
    end
  end

  private
  def find_recipe
    @recipe = Recipe.find_by id: params[:id]
    unless @recipe
      flash[:danger] = t "errors.recipe_not_found"
      redirect_to root_url
    end
  end

  def recipe_params
    params.require(:recipe).permit :name, :cover, :duration,
      :description, :status, steps_attributes: [:order, :_destroy, :content],
      materials_attributes: [:name, :_destroy, :number, :unit]
  end
end
