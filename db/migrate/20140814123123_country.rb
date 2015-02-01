class Country < ActiveRecord::Migration
  def change
      create_table :countries do |t|
      t.string :name
          t.string :iso_code_2
          t.string :iso_code_3
          t.text :address_format
          t.boolean :postcode_required
          t.string :status

      t.timestamps
      end
  end
end
