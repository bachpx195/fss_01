class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.references :recipe, foreign_key: true
      t.text :content, null: false
      t.integer :order, null: false
      t.json :images

      t.timestamps
    end
  end
end
