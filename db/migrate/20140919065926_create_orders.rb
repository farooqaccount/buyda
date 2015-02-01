class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
        t.integer :user_id
        t.integer :order_status_id
        t.integer :invoice_no
        t.decimal :total, precision: 10, scale: 2 
        t.decimal :discounted_total, precision: 10, scale: 2 
      t.timestamps
    end
  end
end
