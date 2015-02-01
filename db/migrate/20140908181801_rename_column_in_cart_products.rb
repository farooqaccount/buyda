class RenameColumnInCartProducts < ActiveRecord::Migration
  def change
      rename_column :cart_products, :user_cart_id, :cart_id
  end
end
