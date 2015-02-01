class CreateAdminCarts < ActiveRecord::Migration
  def change
    create_table :admin_carts do |t|

      t.timestamps
    end
  end
end
