class CreateManufacturerCoupons < ActiveRecord::Migration
  def change
    create_table :manufacturer_coupons do |t|
      t.references :coupons
        t.references :manufacturers
      t.timestamps
    end
  end
end
