class CreateUserCarts < ActiveRecord::Migration
  def change
    create_table :user_carts do |t|

      t.timestamps
    end
  end
end
