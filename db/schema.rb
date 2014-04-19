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

ActiveRecord::Schema.define(version: 20140419011600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: true do |t|
    t.integer  "item_id"
    t.string   "batch_number"
    t.date     "manufacturing_date"
    t.date     "expiration_date"
    t.integer  "stock",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batches", ["item_id", "batch_number"], name: "index_batches_on_item_id_and_batch_number", unique: true, using: :btree

  create_table "invoice_items", force: true do |t|
    t.integer  "batch_id"
    t.integer  "invoice_id",                                             null: false
    t.integer  "item_id",                                                null: false
    t.integer  "quantity",                                 default: 1,   null: false
    t.decimal  "item_price",      precision: 15, scale: 2, default: 0.0
    t.string   "batch_number"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.integer  "provider_id", null: false
    t.string   "number",      null: false
    t.datetime "date",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "label",                       null: false
    t.integer  "minimum_stock",   default: 1
    t.integer  "active",          default: 1
    t.integer  "unit_type_id",    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exempt_from_tax", default: 1
  end

  create_table "providers", force: true do |t|
    t.string   "label"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traces", force: true do |t|
    t.integer  "user_id"
    t.integer  "batch_id"
    t.integer  "value"
    t.string   "type"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "role_id"
    t.integer  "active"
    t.string   "name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
