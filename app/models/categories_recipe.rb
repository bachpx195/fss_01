class CategoriesRecipe < ApplicationRecord
  belongs_to :category
  belongs_to :recipe

  scope :find_by_cate_group, ->cate_group_id {
    joins(:category).where categories: {category_group_id: cate_group_id}}
end
