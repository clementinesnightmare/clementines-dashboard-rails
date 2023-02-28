# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_23_203344) do
  create_table "users", force: :cascade do |t|
    t.string "eth_address"
    t.string "eth_nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lunch_money", default: 0
    t.string "username"
    t.string "twitter_username"
    t.string "discord_username"
    t.boolean "public_profile"
    t.index ["eth_address"], name: "index_users_on_eth_address", unique: true
    t.index ["eth_nonce"], name: "index_users_on_eth_nonce", unique: true
    t.index ["lunch_money"], name: "index_users_on_lunch_money"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
