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

ActiveRecord::Schema.define(version: 20131005182243) do

  create_table "invoice_items", force: true do |t|
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
    t.integer  "provider_id",                                                 null: false
    t.string   "number",                                                      null: false
    t.date     "date",                                 default: '2013-10-14', null: false
    t.decimal  "total",       precision: 15, scale: 2, default: 0.0
    t.decimal  "tax",         precision: 15, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "label",                  null: false
    t.integer  "stock",      default: 0, null: false
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
