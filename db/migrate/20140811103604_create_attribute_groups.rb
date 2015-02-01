class CreateAttributeGroups < ActiveRecord::Migration
  def change
    create_table :attribute_groups do |t|
        t.string :name
        t.integer :sort_order
        t.timestamps
    end
  end
end
