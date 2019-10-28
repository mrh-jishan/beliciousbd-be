class CreateKitchens < ActiveRecord::Migration[6.0]
  def change
    create_table :kitchens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
