# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160302163643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_configurations", force: :cascade do |t|
    t.float    "fee_percent",           default: 2.0
    t.float    "maximum_daily_deposit", default: 1000.0
    t.float    "maximum_deposit",       default: 1000.0
    t.float    "minimum_deposit",       default: 100.0
    t.float    "id_requirement",        default: 1000.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bit_coin_prices", force: :cascade do |t|
    t.decimal  "price",      precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "ip_location"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trades", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "usd_amount",      precision: 8, scale: 2, default: 0.0
    t.decimal  "btc_amount",      precision: 8, scale: 2, default: 0.0
    t.string   "phone_number"
    t.string   "wallet"
    t.string   "username"
    t.string   "email"
    t.string   "status",                                  default: "trade_open"
    t.string   "location_to_pay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",            null: false
    t.string   "encrypted_password",     default: "",            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,             null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "username"
    t.string   "phone_number"
    t.boolean  "sms_verified",           default: false
    t.boolean  "id_verified",            default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status",                 default: "unconfirmed"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
