class CreateApplyCoupons < ActiveRecord::Migration
  def change
    create_table :apply_coupons do |t|
        t.references :coupons
        t.string :type
      t.timestamps
    end
  end
end
