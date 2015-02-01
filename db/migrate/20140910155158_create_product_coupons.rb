class CreateProductCoupons < ActiveRecord::Migration
  def change
    create_table :product_coupons do |t|
        t.references :coupons
        t.references :products
      t.timestamps
    end
  end
end
