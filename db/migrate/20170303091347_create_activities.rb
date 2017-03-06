class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.integer :action_type, null: false, default: 0
      t.string :url, null: false
      t.string :comment

      t.timestamps
    end
  end
end
