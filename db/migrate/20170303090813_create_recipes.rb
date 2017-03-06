class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :description
      t.string :cover
      t.integer :duration
      t.integer :views_count, null: false, default: 0
      t.integer :likes_count, null: false, default: 0
      t.integer :votes_count, null: false, default: 0
      t.float :votes_average, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
