class Step < ApplicationRecord
  mount_uploaders :images, ImageUploader
  belongs_to :recipe

  validates :content, presence: true
  validates :order,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
