class CreateCouponHistories < ActiveRecord::Migration
  def change
    create_table :coupon_histories do |t|
        t.integer :coupon_id
        t.integer :user_id
        t.integer :order_id
        t.decimal :amount, precision: 15, scale: 4
      t.timestamps
    end
  end
end
