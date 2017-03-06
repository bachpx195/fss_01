class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
