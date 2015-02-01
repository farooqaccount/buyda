class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
        t.string :voucher_code
        t.string :from_name
        t.string :from_email
        t.string :to_name
        t.string :to_email
        t.integer :voucher_theme_id
        t.string :message
        t.decimal :amount, precision: 5, scale: 2
        t.boolean :status
      t.timestamps
    end
  end
end
