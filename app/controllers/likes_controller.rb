class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build likes_params
    if @like.save
      respond_to do |format|
        format.js {
          @likeable_item = @like.likeable
        }
      end
    else
      flash[:warning] = t "errors.user_not_found"
      redirect_to root_url
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    if @like
      @likeable_item = @like.likeable
      @like.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:warning] = t "errors.something_wrong"
      redirect_to root_url
    end
  end

  private
  def likes_params
    params.require(:like).permit :likeable_id, :likeable_type
  end
end
