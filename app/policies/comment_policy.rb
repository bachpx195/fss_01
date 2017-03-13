class CommentPolicy
  attr_reader :user, :comment

  def initialize user, comment
    @user = user
    @comment = comment
  end

  def edit?
    update?
  end

  ["update", "destroy"].each do |method|
    define_method "#{method}?" do
      comment.user == user
    end
  end
end
