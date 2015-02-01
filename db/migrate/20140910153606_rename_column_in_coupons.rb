class RenameColumnInCoupons < ActiveRecord::Migration
  def change
      rename_column :coupons, :code, :coupon_code
  end
end
