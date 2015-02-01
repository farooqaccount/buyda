class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.integer :sort_order
      t.belongs_to :attribute_groups
      t.timestamps
    end
  end
end
