class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.integer :property_id
      t.date :payment_date
      t.string :payment_type
      t.decimal :payment_amount
      t.string :payment_mode
      t.text :payment_details

      t.timestamps
    end
  end
end
