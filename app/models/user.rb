class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  scope :sort_by_recipes, -> {joins(:recipes).group("recipes.user_id").order("count(recipes.user_id) desc")}

  mount_uploader :avatar, ImageUploader

  has_many :recipes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy

  enum role: {admin: 0, user: 1}

  validates :name, presence: true, length: {minimum: 5}
  validates :email, presence: true

  def find_liked_by liked_item
    likes.find_by likeable: liked_item
  end

  def find_voted_by recipe
    votes.find_by recipe: recipe
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.name = auth.info.name
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.auth_data"] &&
          session["devise.auth_data"]["extra"]["raw_info"]
          user.email = data["email"]
        end
      end
    end
  end
end
