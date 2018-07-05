# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 20180705155905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parking_zones", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["user_id"], name: "index_parking_zones_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "entry"
    t.datetime "exit"
    t.string "picture"
    t.bigint "parking_zone_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "charge_cents", default: 0, null: false
    t.bigint "entry_user_id"
    t.bigint "exit_user_id"
    t.index ["entry_user_id"], name: "index_tickets_on_entry_user_id"
    t.index ["exit_user_id"], name: "index_tickets_on_exit_user_id"
    t.index ["parking_zone_id"], name: "index_tickets_on_parking_zone_id"
    t.index ["vehicle_id"], name: "index_tickets_on_vehicle_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "debt_cents", default: 0, null: false
  end

  add_foreign_key "parking_zones", "users"
  add_foreign_key "tickets", "parking_zones"
  add_foreign_key "tickets", "users", column: "entry_user_id"
  add_foreign_key "tickets", "users", column: "exit_user_id"
  add_foreign_key "tickets", "vehicles"
end
