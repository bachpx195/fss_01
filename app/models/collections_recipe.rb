class CollectionsRecipe < ApplicationRecord
  belongs_to :collection
  belongs_to :recipe

  scope :find_by_collection, ->id {find_by collection_id: id}
end
