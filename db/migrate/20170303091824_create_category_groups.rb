class CreateCategoryGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :category_groups do |t|
      t.string :name, null: false
      t.boolean :single_select, default: false

      t.timestamps
    end
  end
end
