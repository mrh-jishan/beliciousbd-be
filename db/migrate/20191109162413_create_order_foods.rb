class CreateOrderFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :order_foods do |t|
      t.references :order, null: false, foreign_key: true # order_id of the order table
      t.references :food, null: false, foreign_key: true
      t.references :order_cart, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false  # to save the price during the time of food was purchase since the food price can change

      t.timestamps
    end
  end
end
