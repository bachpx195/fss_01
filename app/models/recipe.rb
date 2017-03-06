class Recipe < ApplicationRecord
  belongs_to :user

  has_many :collections_recipes
  has_many :collections, through: :collections_recipes
  has_many :categories_recipes
  has_many :categories, through: :categories_recipes
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :votes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :materials, dependent: :destroy
end
