class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
        t.integer :order_id
        t.integer :product_id
        t.integer :user_id
        t.integer :quantity
        t.decimal :discounted_price, precision: 5, scale: 2
        t.integer :coupon_id
      t.timestamps
    end
  end
end
