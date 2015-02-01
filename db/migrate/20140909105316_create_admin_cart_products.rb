class CreateAdminCartProducts < ActiveRecord::Migration
  def change
    create_table :admin_cart_products do |t|
        t.references :manufacturer_product
        t.references :user
        t.references :cart
        
      t.timestamps
    end
  end
end
