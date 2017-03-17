class Personal::CollectionsRecipesController < PersonalController
  before_action :find_collections_recipe, only: [:destroy]
  before_action :find_recipe, only: [:show, :update]

  def show
    @collections = current_user.collections
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def update
    if @recipe.update_attributes collection_recipe_params
      respond_to do |format|
        format.js {render layout: false}
      end
    end
  end

  def destroy
    if @collection_recipe.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to [:personal, @collection_recipe.collection]
  end

  private
  def find_collections_recipe
    @collection_recipe = CollectionsRecipe.find_by id: params[:id]
    unless @collection_recipe
      flash[:danger] = t "errors.something_wrong"
      redirect_to personal_root_url
    end
  end

  def collection_recipe_params
    params.require(:recipe).permit collections_recipes_attributes: [:id,
      :_destroy, :collection_id, :recipe_id]
  end

  def find_recipe
    @recipe = Recipe.find_by id: params[:id]
    unless @recipe
      flash[:danger] = t "errors.recipe_not_found"
      redirect_to root_url
    end
  end
end
