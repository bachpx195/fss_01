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

  enum status: [private: 0, published: 1, edit_request: 2, publish_request: 3]

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :materials, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates :cover, presence: true
  validates :duration, numericality: :true, allow_nil: true

end
