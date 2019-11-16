class CreateOrderRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_ratings do |t|
      t.references :order, null: false, foreign_key: true # order_id of the order table
      t.references :user, null: false, foreign_key: true # order_id of the order table
      t.integer :rating, null: false, :n => 0..5
      t.text :comment, null: false
      t.timestamps
    end
    add_index :order_ratings, [:user_id, :order_id], unique: true
  end
end
