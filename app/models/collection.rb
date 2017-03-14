class Collection < ApplicationRecord
  mount_uploader :cover, ImageUploader

  belongs_to :user

  has_many :collections_recipes, dependent: :destroy
  has_many :recipes, through: :collections_recipes
  has_many :likes, as: :likeable
end
