class CreateOrderShippingDetails < ActiveRecord::Migration
  def change
    create_table :order_shipping_details do |t|
        t.integer :order_id
        t.integer :user_id
        t.integer :order_payment_detail_id
        t.string :name, :limit => 255
        t.text :address
        t.string :zip_code, :limit => 20
      t.timestamps
    end
  end
end
