class RenameColumnNameTypeToProductTypeInProductOptions < ActiveRecord::Migration
  def change
      rename_column :product_options, :type, :option_type
  end
end
