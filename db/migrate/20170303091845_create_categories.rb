class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.references :category_group, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
