class Recipe < ApplicationRecord
  scope :filter_by_categories, -> category_ids {
    joins(:categories_recipes)
      .where({categories_recipes: {category_id: category_ids}})
      .group(:id)
      .having "count(distinct categories_recipes.category_id) = ?",
        category_ids.count
  }

  belongs_to :user
  mount_uploader :cover, ImageUploader
  scope :order_desc, ->{order created_at: :desc}
  scope :not_draft, ->{where.not status: :draft}

  cattr_accessor :form_steps do
    %w(confirm_material confirm_step confirm_category)
  end

  after_create :update_status

  has_many :collections_recipes, dependent: :destroy
  has_many :collections, through: :collections_recipes
  has_many :categories_recipes, dependent: :destroy
  has_many :categories, through: :categories_recipes
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :votes, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :materials, dependent: :destroy

  accepts_nested_attributes_for :steps, allow_destroy: true,
    reject_if: :all_blank
  accepts_nested_attributes_for :materials, allow_destroy: true,
    reject_if: :all_blank
  accepts_nested_attributes_for :categories_recipes, allow_destroy: true,
    reject_if: :all_blank

  enum status: {draft: 0, published: 1, edit_request: 2, publish_request: 3}

  validates :name, presence: true
  validates :description, presence: true
  validates :cover, presence: true
  validates :duration, numericality: :true, allow_nil: true

  def list_categories
    categories.includes :category_group
  end

  def list_comments
    comments.includes(:user).by_posted_time
  end

  private
  def update_status
    update_attributes status: Recipe.statuses[:draft]
  end
end
