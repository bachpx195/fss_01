class CollectionsController < ApplicationController
  before_action :find_collection, only: :show

  def index
    @collections = Collection.paginate page: params[:page],
      per_page: Settings.per_page.collections_index
    @collections_count = Collection.count
  end

  def new
    @recipe = Recipe.find_by id: params[:recipe_id]
    @collection = Collection.new
  end

  def create
    @collection = current_user.collections.build collection_params
    if @collection.save
      @recipe = Recipe.find_by id: params[:recipe_id]
      @collections = current_user.collections
      respond_to do |format|
        format.js {render layout: false}
      end
    end
  end

  def show
  end

  private
  def find_collection
    @collection = Collection.find_by id: params[:id]
    unless @collection
      flash[:danger] = t "errors.collection_not_found"
      redirect_to root_url
    end
  end

  def collection_params
    params.require(:collection).permit :name, :description, :cover, :cover_cache
  end
end
