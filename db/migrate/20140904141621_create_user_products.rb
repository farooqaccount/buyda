class CreateUserProducts < ActiveRecord::Migration
  def change
    create_table :user_products do |t|
        t.references :product
        t.references :user
        t.references :user_cart
      t.timestamps
    end
  end
end
