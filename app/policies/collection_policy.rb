class CollectionPolicy < ApplicationPolicy
  attr_reader :user, :collection

  def initialize user, collection
    @user = user
    @collection = collection
  end

  ["update", "destroy"].each do |method|
    define_method "#{method}?" do
      @user == @collection.user
    end
  end
end
