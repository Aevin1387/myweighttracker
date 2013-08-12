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

ActiveRecord::Schema.define(version: 20130812030154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: true do |t|
    t.integer  "user_id"
    t.float    "weight"
    t.float    "fat"
    t.date     "measured_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "imported_to_fitbit",   default: false, null: false
    t.boolean  "imported_to_withings", default: false, null: false
  end

  add_index "measurements", ["imported_to_fitbit"], name: "index_measurements_on_imported_to_fitbit", using: :btree
  add_index "measurements", ["imported_to_withings"], name: "index_measurements_on_imported_to_withings", using: :btree
  add_index "measurements", ["user_id"], name: "index_measurements_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "sign_in_count",      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
