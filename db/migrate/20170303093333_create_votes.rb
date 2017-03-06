class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.integer :vote, null: false, default: 1

      t.index [:user_id, :recipe_id], unique: true
      t.timestamps
    end
  end
end
