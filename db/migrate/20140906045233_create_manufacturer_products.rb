class CreateManufacturerProducts < ActiveRecord::Migration
  def change
    create_table :manufacturer_products do |t|
        t.references :manufacturer
        t.references :category
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
      t.timestamps
    end
  end
end
