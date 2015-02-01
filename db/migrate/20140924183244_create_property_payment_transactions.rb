class CreatePropertyPaymentTransactions < ActiveRecord::Migration
  def change
    create_table :property_payment_transactions do |t|
      t.integer :property_id
      t.integer :payment_detail_id
      t.date :payment_date

      t.timestamps
    end
  end
end
