class AddColumnToManufacturerCoupons < ActiveRecord::Migration
  def change
      add_column :manufacturer_coupons, :manufacturer_id, :integer
  end
end
