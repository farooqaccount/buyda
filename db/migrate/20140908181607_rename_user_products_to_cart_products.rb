class RenameUserProductsToCartProducts < ActiveRecord::Migration
  def change
      rename_table :user_products, :cart_products
  end
end
