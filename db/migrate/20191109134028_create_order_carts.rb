class CreateOrderCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_carts do |t|
      
      # set the user - customer and chef in the User model
      t.references :customer, null: false
      t.references :chef, null: false

      t.references :food, null: false, foreign_key: true
      t.boolean :processed, :default=>false, null: false    

      t.timestamps
    end
  end
end
