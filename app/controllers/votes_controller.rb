class VotesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :destroy]
  before_action :find_recipe, except: [:index, :show, :destroy]
  before_action :find_vote, only: [:edit, :update]

  def new
    @vote = @recipe.votes.build
    respond_to do |format|
      format.js
    end
  end

  def create
    VoteRecipeService.new(current_user, @recipe, vote_params).vote
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    VoteRecipeService.new(current_user, @recipe, vote_params).vote
    respond_to do |format|
      format.js
    end
  end

  private
  def find_vote
    @vote = Vote.find_by id: params[:id]
    unless @vote
      flash[:danger] = t "errors.something_wrong"
      redirect_to :back
    end
  end

  def find_recipe
    @recipe = Recipe.find_by id: params[:recipe_id]
    unless @recipe
      flash[:danger] = t "errors.recipe_not_found"
      redirect_to root_url
    end
  end

  def vote_params
    params.require(:vote).permit :vote, :recipe_id
  end
end
