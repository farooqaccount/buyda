class AddColumnToCartProducts < ActiveRecord::Migration
  def change
      add_column :cart_products, :has_coupon, :boolean, :default => false
  end
end
