class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
        t.string :name
        t.integer :sort_order
        t.integer :option_id
      t.timestamps
    end
  end
end
