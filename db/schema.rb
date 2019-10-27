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

ActiveRecord::Schema.define(version: 2019_10_24_170020) do

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id"
    t.text "address", null: false
    t.string "city", limit: 64, null: false
    t.string "state", limit: 64, null: false
    t.string "zip_code", limit: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 40, null: false
    t.string "last_name", limit: 40, null: false
    t.string "gender", limit: 10, null: false
    t.text "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "addresses", "users"
end
