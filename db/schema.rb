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

ActiveRecord::Schema[7.2].define(version: 2024_10_09_145709) do
  create_table "bookings", force: :cascade do |t|
    t.integer "pool_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pool_id"], name: "index_bookings_on_pool_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "place_type"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pools", force: :cascade do |t|
    t.string "pool_type"
    t.integer "user_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "start_place_id", null: false
    t.integer "end_place_id", null: false
    t.integer "user_max"
    t.integer "user_min"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_place_id"], name: "index_pools_on_end_place_id"
    t.index ["start_place_id"], name: "index_pools_on_start_place_id"
    t.index ["user_id"], name: "index_pools_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "pools", on_delete: :nullify
  add_foreign_key "bookings", "users", on_delete: :nullify
  add_foreign_key "pools", "places", column: "end_place_id", on_delete: :nullify
  add_foreign_key "pools", "places", column: "start_place_id", on_delete: :nullify
  add_foreign_key "pools", "users", on_delete: :nullify
end
