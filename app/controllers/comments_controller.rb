class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build comment_params
    @new_comment = @comment.recipe.comments.build if @comment.save
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
    if @comment.update_attributes comment_params
      @new_comment = @comment.recipe.comments.build
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def find_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "errors.something_wrong"
      redirect_to root_url
    end
  end

  def authorize_comment
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit :user_id, :recipe_id, :content, {images: []}
  end
end
