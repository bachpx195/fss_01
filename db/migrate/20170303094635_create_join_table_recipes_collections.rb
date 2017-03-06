class CreateJoinTableRecipesCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections_recipes do |t|
      t.references :recipe, foreign_key: true
      t.references :collection, foreign_key: true
      t.index [:recipe_id, :collection_id], unique: true
    end
  end
end
