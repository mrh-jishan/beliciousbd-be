class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.references :kitchen, null: false, foreign_key: true
      t.string :name, null: false
      t.string :category, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description, null: false
      t.text :reciepe

      t.timestamps
    end
  end
end
