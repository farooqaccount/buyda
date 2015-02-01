class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property_code
      t.integer :state_id
      t.integer :district_id
      t.integer :land_lord_id
      t.text :address
      t.date :lease_start_date
      t.date :lease_end_date
      t.integer :rent_amount
      t.text :remarks

      t.timestamps
    end
  end
end
