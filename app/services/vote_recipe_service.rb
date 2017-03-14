class VoteRecipeService
  def initialize user, recipe, vote_params
    @user = user
    @recipe = recipe
    @vote_params = vote_params
  end

  def vote
    if voted_item = @user.find_voted_by(@recipe)
      voted_item.update_attributes @vote_params
    else
      @user.votes.build(@vote_params).save
    end
    votes_count = @recipe.votes.count
    votes_average = (@recipe.votes.sum(:vote) / votes_count).round
    @recipe.update_attributes votes_count: votes_count,
      votes_average: votes_average
  end
end
