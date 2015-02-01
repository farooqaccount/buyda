class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
        t.string :name
        t.string :code
        t.string :status
        t.integer :country_id
      t.timestamps
    end
  end
end
