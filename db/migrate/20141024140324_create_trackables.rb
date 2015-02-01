class CreateTrackables < ActiveRecord::Migration
  def change
    create_table :trackables do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
