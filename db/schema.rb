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

ActiveRecord::Schema.define(version: 20141112143250) do

  create_table "admin_cart_products", force: true do |t|
    t.integer  "manufacturer_product_id"
    t.integer  "user_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apply_coupons", force: true do |t|
    t.integer  "coupon_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attribute_groups", force: true do |t|
    t.string   "name"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attributes", force: true do |t|
    t.string   "name"
    t.integer  "sort_order"
    t.integer  "attribute_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_products", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.boolean  "has_coupon",                            default: false
    t.decimal  "product_price", precision: 5, scale: 2
  end

  create_table "carts", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "is_active"
    t.text     "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.string   "ancestry"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry"

  create_table "category_coupons", force: true do |t|
    t.integer  "coupon_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "iso_code_2"
    t.string   "iso_code_3"
    t.text     "address_format"
    t.boolean  "postcode_required"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupon_histories", force: true do |t|
    t.integer  "coupon_id"
    t.integer  "user_id"
    t.integer  "order_id"
    t.decimal  "amount",     precision: 15, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: true do |t|
    t.string   "coupon_code"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "coupon_type"
    t.decimal  "discount",                    precision: 5, scale: 2
    t.integer  "usage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_amount",                precision: 5, scale: 2
    t.boolean  "user_logged_in"
    t.integer  "uses_per_coupon", limit: 255
    t.integer  "uses_per_user",   limit: 255
  end

  create_table "currencies", force: true do |t|
    t.string   "title"
    t.string   "code"
    t.string   "symbol_left"
    t.string   "symbol_right"
    t.integer  "decimal_place"
    t.decimal  "value"
    t.string   "status"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.datetime "date_added"
    t.string   "mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "locale"
    t.string   "directory"
    t.string   "filename"
    t.integer  "sort_order"
    t.string   "status"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "length_classes", force: true do |t|
    t.string   "title"
    t.string   "unit"
    t.decimal  "value",      precision: 15, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturer_coupons", force: true do |t|
    t.integer  "coupon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manufacturer_id"
  end

  create_table "manufacturer_products", force: true do |t|
    t.integer  "manufacturer_id"
    t.integer  "category_id"
    t.string   "name"
    t.text     "description",         limit: 255
    t.decimal  "price",                           precision: 10, scale: 2
    t.string   "title"
    t.string   "in_stock"
    t.boolean  "reduce_stock"
    t.string   "require_shipping"
    t.date     "manufactuering_date"
    t.datetime "active_from"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: true do |t|
    t.string   "name"
    t.string   "poc"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_histories", force: true do |t|
    t.integer  "order_id"
    t.integer  "order_status_id"
    t.boolean  "notify"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.decimal  "discounted_price", precision: 5, scale: 2
    t.integer  "coupon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_shipping_details", force: true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "address"
    t.string   "zip_code",   limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", force: true do |t|
    t.string   "name"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "send_email", default: false
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "order_status_id"
    t.integer  "invoice_no"
    t.decimal  "total",            precision: 10, scale: 2
    t.decimal  "discounted_total", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "address"
    t.string   "payment_type"
    t.integer  "cart_id"
  end

  create_table "payment_details", force: true do |t|
    t.integer  "property_id"
    t.date     "payment_date"
    t.string   "payment_type"
    t.decimal  "payment_amount"
    t.string   "payment_mode"
    t.text     "payment_details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_coupons", force: true do |t|
    t.integer  "coupon_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_option_values", force: true do |t|
    t.string   "name"
    t.integer  "sort_order"
    t.integer  "product_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_options", force: true do |t|
    t.string   "name"
    t.string   "option_type"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description",         limit: 255
    t.decimal  "price",                           precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "manufacturer_id"
    t.integer  "category_id"
    t.string   "in_stock"
    t.boolean  "reduce_stock"
    t.string   "require_shipping"
    t.date     "manufactuering_date"
    t.datetime "active_from"
    t.integer  "user_id"
    t.integer  "quantity"
    t.string   "permalink"
  end

  create_table "products_sub_categories", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "sub_category_id"
  end

  create_table "profiles", force: true do |t|
    t.string   "company"
    t.text     "address1"
    t.text     "address2"
    t.string   "city"
    t.string   "postcode"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "property_code"
    t.integer  "country_id"
    t.integer  "zone_id"
    t.integer  "land_lord_id"
    t.text     "address"
    t.date     "lease_start_date"
    t.date     "lease_end_date"
    t.integer  "rent_amount"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "property_payment_transactions", force: true do |t|
    t.integer  "property_id"
    t.integer  "payment_detail_id"
    t.date     "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "return_actions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "return_reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "return_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
  end

  create_table "reviews", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "author"
    t.text     "description"
    t.integer  "rating"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "stock_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
  end

  create_table "sub_categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackables", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "guest"
    t.boolean  "subscribe_newsletter"
    t.string   "phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "voucher_themes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vouchers", force: true do |t|
    t.string   "voucher_code"
    t.string   "from_name"
    t.string   "from_email"
    t.string   "to_name"
    t.string   "to_email"
    t.integer  "voucher_theme_id"
    t.string   "message"
    t.decimal  "amount",           precision: 5, scale: 2
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weight_classes", force: true do |t|
    t.string   "title"
    t.string   "unit"
    t.decimal  "value",      precision: 15, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlist_items", force: true do |t|
    t.integer  "wishlist_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlists", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "status"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
