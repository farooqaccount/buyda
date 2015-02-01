class RemoveColumnFromOrderShippingDetails < ActiveRecord::Migration
  def change
      remove_column :order_shipping_details, :order_payment_detail_id
  end
end
