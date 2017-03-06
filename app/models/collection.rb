class Collection < ApplicationRecord
  belongs_to :user

  has_many :collections_recipes
  has_many :recipes, through: :collections_recipes
  has_many :likes, as: :likeable
end
