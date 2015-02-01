class ChangeColumnInCoupons < ActiveRecord::Migration
  def change
      change_column :coupons, :uses_per_coupon, :integer
      change_column :coupons, :uses_per_user, :integer
  end
end
