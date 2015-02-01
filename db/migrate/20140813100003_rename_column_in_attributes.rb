class RenameColumnInAttributes < ActiveRecord::Migration
  def change
      rename_column :attributes, :attribute_groups_id, :attribute_group_id
  end
end
