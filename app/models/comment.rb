class Comment < ApplicationRecord
  scope :by_posted_time, -> {order created_at: :desc}

  belongs_to :user
  belongs_to :recipe

  has_many :likes, as: :likeable

  validates :content, presence: :true
end
