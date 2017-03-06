class CreateJoinTableRecipesCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_recipes do |t|
      t.references :recipe, foreign_key: true
      t.references :category, foreign_key: true
      t.index [:recipe_id, :category_id], unique: true
    end
  end
end
