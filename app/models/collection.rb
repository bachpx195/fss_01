class Collection < ApplicationRecord
  scope :sort_by_view, ->{order views_count: :desc}

  mount_uploader :cover, ImageUploader

  belongs_to :user

  has_many :collections_recipes, dependent: :destroy
  has_many :recipes, through: :collections_recipes
  has_many :likes, as: :likeable

  validates :name, presence: true, length: {minimum: 5}

  def feeds
    collections_recipes.includes :recipe
  end
end
