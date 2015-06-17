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

ActiveRecord::Schema.define(version: 20150617171207) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type"
    t.integer  "actable_id"
    t.string   "actable_type"
  end

  create_table "bookings", force: :cascade do |t|
    t.date     "date"
    t.integer  "accounts_id"
    t.decimal  "amount"
    t.string   "note1"
    t.string   "note2"
    t.string   "remarks"
    t.integer  "accounting_number"
    t.integer  "created_by_ID"
    t.integer  "updated_by_ID"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "bookings", ["accounts_id"], name: "index_bookings_on_accounts_id"

  create_table "child_consumptions", force: :cascade do |t|
    t.integer  "child_id"
    t.date     "date"
    t.string   "time_of_day"
    t.integer  "soft_drink"
    t.decimal  "other"
    t.string   "created_by"
    t.string   "edited_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "child_consumptions", ["child_id"], name: "index_child_consumptions_on_child_id"

  create_table "children", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tent_id"
  end

  add_index "children", ["tent_id"], name: "index_children_on_tent_id"

  create_table "children_accounts", force: :cascade do |t|
    t.integer  "children_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "children_accounts", ["children_id"], name: "index_children_accounts_on_children_id"

  create_table "disbursements", force: :cascade do |t|
    t.date     "date"
    t.integer  "accounts_id"
    t.boolean  "cleared"
    t.decimal  "amount",      precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "disbursements", ["accounts_id"], name: "index_disbursements_on_accounts_id"

  create_table "goods", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 10, scale: 2
    t.date     "date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
  end

  create_table "main_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scout_consumptions", force: :cascade do |t|
    t.date     "date"
    t.integer  "scout_id"
    t.integer  "beer"
    t.integer  "soft_drink"
    t.integer  "sausage"
    t.integer  "pork"
    t.integer  "turkey"
    t.decimal  "other",      precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "created_by"
    t.string   "edited_by"
    t.string   "notes"
  end

  add_index "scout_consumptions", ["scout_id"], name: "index_scout_consumptions_on_scout_id"

  create_table "scouts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tent_id"
  end

  add_index "scouts", ["tent_id"], name: "index_scouts_on_tent_id"

  create_table "scouts_accounts", force: :cascade do |t|
    t.integer  "scouts_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "scouts_accounts", ["scouts_id"], name: "index_scouts_accounts_on_scouts_id"

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
  end

  create_table "tents", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
