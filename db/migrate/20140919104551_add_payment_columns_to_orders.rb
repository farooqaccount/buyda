class AddPaymentColumnsToOrders < ActiveRecord::Migration
  def change
      add_column :orders, :name, :string, :limit => 255
      add_column :orders, :address, :text
      add_column :orders, :payment_type, :string
      
      drop_table :order_payment_details
  end
end
