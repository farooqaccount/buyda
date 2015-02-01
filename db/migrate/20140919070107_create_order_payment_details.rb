class CreateOrderPaymentDetails < ActiveRecord::Migration
  def change
    create_table :order_payment_details do |t|
        t.integer :order_id
        t.integer :user_id
        t.string :name, :limit => 255
        t.text :address
        t.string :payment_type
      t.timestamps
    end
  end
end
