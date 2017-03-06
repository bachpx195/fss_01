class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.references :recipe, foreign_key: true
      t.string :name, null: false
      t.float :number
      t.string :unit

      t.timestamps
    end
  end
end
