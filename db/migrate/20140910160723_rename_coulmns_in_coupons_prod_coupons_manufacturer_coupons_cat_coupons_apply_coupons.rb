class RenameCoulmnsInCouponsProdCouponsManufacturerCouponsCatCouponsApplyCoupons < ActiveRecord::Migration
  def change
      rename_column :product_coupons, :coupons_id, :coupon_id
      rename_column :product_coupons, :products_id, :product_id
      rename_column :manufacturer_coupons, :coupons_id, :coupon_id
      rename_column :manufacturer_coupons, :manufacturers_id, :coupon_id
      rename_column :category_coupons, :coupons_id, :coupon_id
      rename_column :category_coupons, :categories_id, :category_id
      rename_column :apply_coupons, :coupons_id, :coupon_id
  end
end
