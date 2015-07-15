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

ActiveRecord::Schema.define(version: 20150715082505) do

  create_table "assets", force: true do |t|
    t.string   "data",                                      null: false
    t.integer  "assetable_id"
    t.string   "assetable_type", limit: 30,                 null: false
    t.string   "type",           limit: 30
    t.string   "guid",           limit: 50
    t.boolean  "is_main",                   default: false
    t.integer  "position",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
  end

  add_index "assets", ["assetable_type", "type", "assetable_id"], name: "index_assets_on_assetable_type_and_type_and_assetable_id", using: :btree
  add_index "assets", ["guid"], name: "index_assets_on_guid", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "long"
    t.integer  "zoom",       default: 1
  end

  create_table "product_translations", force: true do |t|
    t.integer  "product_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "product_translations", ["locale"], name: "index_product_translations_on_locale", using: :btree
  add_index "product_translations", ["product_id"], name: "index_product_translations_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "title"
    t.decimal  "price",      precision: 10, scale: 0
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                           default: true
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
