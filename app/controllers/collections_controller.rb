class CollectionsController < ApplicationController
  before_action :find_collection, only: [:show]

  def index
    @collections = Collection.paginate page: params[:page]
    @collections_count = Collection.count
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
end
