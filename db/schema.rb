ActiveRecord::Schema[7.0].define(version: 2022_11_27_200033) do
  create_table "users", force: :cascade do |t|
    t.string "eth_address"
    t.string "eth_nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eth_address"], name: "index_users_on_eth_address", unique: true
    t.index ["eth_nonce"], name: "index_users_on_eth_nonce", unique: true
  end
end
