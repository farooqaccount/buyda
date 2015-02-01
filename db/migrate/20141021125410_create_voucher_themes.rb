class CreateVoucherThemes < ActiveRecord::Migration
  def change
    create_table :voucher_themes do |t|
        t.string :name
      t.timestamps
    end
  end
end
