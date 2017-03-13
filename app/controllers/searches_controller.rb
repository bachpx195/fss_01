class SearchesController < ApplicationController
  include ApplicationHelper

  def index
    @recipes = @q.result(distinct: true).published
    unless category_keys.blank?
      @recipes = @recipes.filter_by_categories category_keys
    end
    @category_groups = CategoryGroup.all.includes(:categories)
    respond_to do |format|
      format.js
      format.html
    end
  end
end
