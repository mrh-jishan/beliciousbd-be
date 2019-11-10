# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_09_162413) do

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "address", null: false
    t.string "city", limit: 64, null: false
    t.string "state", limit: 64, null: false
    t.string "zip_code", limit: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id", unique: true
  end

  create_table "foods", force: :cascade do |t|
    t.integer "kitchen_id", null: false
    t.string "name", null: false
    t.string "category", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "description", null: false
    t.text "reciepe"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kitchen_id"], name: "index_foods_on_kitchen_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.integer "food_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_ingredients_on_food_id"
  end

  create_table "kitchens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_kitchens_on_user_id"
  end

  create_table "order_carts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "chef_id", null: false
    t.integer "food_id", null: false
    t.boolean "processed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chef_id"], name: "index_order_carts_on_chef_id"
    t.index ["customer_id"], name: "index_order_carts_on_customer_id"
    t.index ["food_id"], name: "index_order_carts_on_food_id"
  end

  create_table "order_foods", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "food_id", null: false
    t.integer "order_cart_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_order_foods_on_food_id"
    t.index ["order_cart_id"], name: "index_order_foods_on_order_cart_id"
    t.index ["order_id"], name: "index_order_foods_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "status", default: "created", null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.string "order_mode", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "kitchen_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kitchen_id"], name: "index_tags_on_kitchen_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 40, null: false
    t.string "last_name", limit: 40, null: false
    t.string "gender", limit: 10, null: false
    t.string "email", null: false
    t.string "confirm_token", null: false
    t.boolean "email_confirmed", default: false, null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirm_token"], name: "index_users_on_confirm_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "foods", "kitchens"
  add_foreign_key "ingredients", "foods"
  add_foreign_key "kitchens", "users"
  add_foreign_key "order_carts", "foods"
  add_foreign_key "order_foods", "foods"
  add_foreign_key "order_foods", "order_carts"
  add_foreign_key "order_foods", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "tags", "kitchens"
end
