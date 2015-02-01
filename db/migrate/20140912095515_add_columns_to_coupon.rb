class AddColumnsToCoupon < ActiveRecord::Migration
  def change
      add_column :coupons, :total_amount, :decimal, precision: 5, scale: 2
      add_column :coupons, :user_logged_in, :boolean
      add_column :coupons, :uses_per_coupon, :string
      add_column :coupons, :uses_per_user, :string
  end
end
