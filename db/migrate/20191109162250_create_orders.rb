class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, :default => 1
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :order_mode, null: false #if customer receive the order or the chef will deliver
      
      t.timestamps
    end
  end
end
