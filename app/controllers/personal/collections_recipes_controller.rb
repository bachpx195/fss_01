class Personal::CollectionsRecipesController < PersonalController
  before_action :find_collections_recipe, only: [:destroy]

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
end
