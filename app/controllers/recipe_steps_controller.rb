class RecipeStepsController < ApplicationController
  include Wicked::Wizard

  steps *Recipe.form_steps

  before_action :find_recipe, only: [:show, :update, :finish_wizard_path]

  def show
    @category_groups = CategoryGroup.all.includes(:categories)
    render_wizard
  end

  def update
    if step == Settings.step.confirm_category
      if params[:commit]
        @recipe.update_attributes status: Recipe.statuses[:published]
      else
        @recipe.update_attributes status: Recipe.statuses[:draft]
      end
    end
    if params[:recipe]
      @recipe.update_attributes step_recipe_params
    end
    render_wizard @recipe
  end

  private
  def find_recipe
    @recipe = Recipe.find_by id: params[:recipe_id]
    unless @recipe
      flash[:danger] = t "errors.recipe_not_found"
      redirect_to root_url
    end
  end

  def step_recipe_params
    params.require(:recipe).permit :status,
      materials_attributes: [:id, :name, :_destroy, :number, :unit],
      steps_attributes: [:id, :order, :_destroy, :content, {images: []}],
      categories_recipes_attributes: [:id, :category_id, :recipe_id]
  end

  def finish_wizard_path
    recipe_path @recipe
  end
end
