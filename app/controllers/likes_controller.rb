class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build likes_params
    unless @likeable_item = @like.likeable
      flash[:warning] = t "errors.something_wrong"
      redirect_to :back
    end
    unless current_user.find_liked_by @likeable_item
      @like.save
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    if @like
      @likeable_item = @like.likeable
      @like.destroy
    else
      flash[:warning] = t "errors.something_wrong"
      redirect_to :back
    end
  end

  private
  def likes_params
    params.require(:like).permit :likeable_id, :likeable_type
  end
end
