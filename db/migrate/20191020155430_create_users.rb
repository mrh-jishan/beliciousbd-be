class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 40, null: false
      t.string :last_name, limit: 40, null: false
      t.string :gender, limit: 10, null: false
      t.string :email, null: false
      t.string :confirm_token, null: false
      t.boolean :email_confirmed, :default=>false, null: false    
      t.string :password_digest, null: false
      t.string :role, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :confirm_token, unique: true
  end
end
