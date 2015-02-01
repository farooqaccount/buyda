class AddProductPriceColumnToCartProducts < ActiveRecord::Migration
  def change
      add_column :cart_products, :product_price, :decimal, precision: 5, scale: 2
  end
end
