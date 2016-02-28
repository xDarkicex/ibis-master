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

ActiveRecord::Schema.define(version: 20160129213149) do

  create_table "adjustments", force: :cascade do |t|
    t.string   "source_type"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "images", force: :cascade do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "product_id"
    t.string   "alt"
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "header"
    t.string   "content"
  end

  create_table "piggybak_addresses", force: :cascade do |t|
    t.string   "firstname",  null: false
    t.string   "lastname",   null: false
    t.string   "address1",   null: false
    t.string   "address2"
    t.string   "city",       null: false
    t.string   "state_id",   null: false
    t.integer  "country_id", null: false
    t.string   "zip",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_countries", force: :cascade do |t|
    t.string  "name"
    t.string  "abbr"
    t.boolean "active_shipping", default: false
    t.boolean "active_billing",  default: false
  end

  create_table "piggybak_line_items", force: :cascade do |t|
    t.integer  "order_id",                                                     null: false
    t.integer  "quantity",                                                     null: false
    t.integer  "sellable_id"
    t.decimal  "price",          precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "unit_price",     precision: 10, scale: 2, default: 0.0,        null: false
    t.string   "description",                             default: "",         null: false
    t.string   "line_item_type",                          default: "sellable", null: false
  end

  create_table "piggybak_order_notes", force: :cascade do |t|
    t.integer  "order_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_orders", force: :cascade do |t|
    t.integer  "billing_address_id",                                           null: false
    t.integer  "shipping_address_id",                                          null: false
    t.integer  "user_id"
    t.string   "email",                                                        null: false
    t.string   "phone",                                                        null: false
    t.decimal  "total",               precision: 10, scale: 2,                 null: false
    t.decimal  "total_due",           precision: 10, scale: 2,                 null: false
    t.string   "status",                                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.text     "user_agent"
    t.boolean  "to_be_cancelled",                              default: false
    t.boolean  "confirmation_sent",                            default: false
  end

  create_table "piggybak_payment_method_values", force: :cascade do |t|
    t.integer "payment_method_id"
    t.string  "key"
    t.string  "value"
  end

  create_table "piggybak_payment_methods", force: :cascade do |t|
    t.string   "description",                 null: false
    t.string   "klass",                       null: false
    t.boolean  "active",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_payments", force: :cascade do |t|
    t.integer  "payment_method_id"
    t.string   "status",            default: "paid", null: false
    t.integer  "month"
    t.integer  "year"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "masked_number"
    t.integer  "line_item_id"
  end

  create_table "piggybak_sellables", force: :cascade do |t|
    t.string  "sku",                                                          null: false
    t.string  "description",                                                  null: false
    t.decimal "price",               precision: 10, scale: 2,                 null: false
    t.integer "quantity",                                     default: 0,     null: false
    t.integer "item_id",                                                      null: false
    t.string  "item_type",                                                    null: false
    t.boolean "active",                                       default: false, null: false
    t.boolean "unlimited_inventory",                          default: false, null: false
  end

  create_table "piggybak_shipments", force: :cascade do |t|
    t.integer  "shipping_method_id",                 null: false
    t.string   "status",             default: "new", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_item_id"
  end

  create_table "piggybak_shipping_method_values", force: :cascade do |t|
    t.integer "shipping_method_id"
    t.string  "key"
    t.string  "value"
  end

  create_table "piggybak_shipping_methods", force: :cascade do |t|
    t.string  "description",                 null: false
    t.string  "klass",                       null: false
    t.boolean "active",      default: false, null: false
  end

  create_table "piggybak_states", force: :cascade do |t|
    t.string  "name"
    t.string  "abbr"
    t.integer "country_id"
  end

  create_table "piggybak_tax_method_values", force: :cascade do |t|
    t.integer "tax_method_id"
    t.string  "key"
    t.string  "value"
  end

  create_table "piggybak_tax_methods", force: :cascade do |t|
    t.string  "description",                 null: false
    t.string  "klass",                       null: false
    t.boolean "active",      default: false, null: false
  end

  create_table "piggybak_taxonomy_navigation_nodes", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "position"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "piggybak_taxonomy_navigation_nodes", ["ancestry"], name: "index_piggybak_taxonomy_navigation_nodes_on_ancestry"

  create_table "piggybak_taxonomy_sellable_taxonomies", force: :cascade do |t|
    t.integer "navigation_node_id",             null: false
    t.integer "sellable_id",                    null: false
    t.integer "sort",               default: 0, null: false
  end

  create_table "piggybak_variants_option_configurations", force: :cascade do |t|
    t.string   "klass",      null: false
    t.integer  "option_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_variants_option_values", force: :cascade do |t|
    t.integer  "option_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_variants_option_values_variants", id: false, force: :cascade do |t|
    t.integer "option_value_id"
    t.integer "variant_id"
  end

  create_table "piggybak_variants_options", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "piggybak_variants_variants", force: :cascade do |t|
    t.integer  "item_id",    null: false
    t.string   "item_type",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "mens"
  end

  create_table "search_engine_optimizations", force: :cascade do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slides", force: :cascade do |t|
    t.string   "body"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "header"
    t.string   "sub_header"
    t.string   "button_name"
    t.string   "url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
