class DeleteColumnFromWishlists < ActiveRecord::Migration
  def change
      remove_column :wishlists, :product_id
  end
end
