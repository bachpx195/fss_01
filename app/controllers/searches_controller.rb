class SearchesController < ApplicationController
  include SearchesHelper

  def index
    search_and_sort_results
    @category_groups = CategoryGroup.all.includes(:categories)
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def search_and_sort_results
    @recipes = @q.result(distinct: true).published
    unless category_keys.blank?
      @recipes = @recipes.filter_by_categories category_keys
    end
    if params.has_key?:sort_by
    	@recipes = @recipes.send "sort_by_#{params[:sort_by]}"
    end
  end
end
