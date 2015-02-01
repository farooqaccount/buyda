class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :company
      t.text :address1
      t.text :address2
      t.string :city
      t.string :postcode
      t.string :country
      t.integer :user_id

      t.timestamps
    end
  end
end
