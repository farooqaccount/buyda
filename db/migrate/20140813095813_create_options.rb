class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
        t.string :name
        t.string :type
        t.integer :sort_order
        
      t.timestamps
    end
  end
end
