class CreateCategoryCoupons < ActiveRecord::Migration
  def change
    create_table :category_coupons do |t|
      t.references :coupons
        t.references :categories
      t.timestamps
    end
  end
end
