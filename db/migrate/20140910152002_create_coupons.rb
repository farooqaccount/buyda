class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
        t.string :code
        t.datetime :start_date
        t.datetime :end_date
        t.string :coupon_type
        t.decimal :discount, precision: 5, scale: 2 
        t.integer :usage
      t.timestamps
    end
  end
end
