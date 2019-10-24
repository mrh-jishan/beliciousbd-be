class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 40, null: false
      t.string :last_name, limit: 40, null: false

      t.string :gender, limit: 10, null: false

      t.text :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
