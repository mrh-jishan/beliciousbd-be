class CreateKitchenAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :kitchen_addresses do |t|
      t.references :kitchen, index: {unique: true}, null: false, foreign_key: true
      t.text :address, null: false
      t.string :city, limit: 64, null: false
      t.string :state, limit: 64, null: false
      t.string :zip_code, limit: 10, null: false

      t.timestamps
    end
  end
end
