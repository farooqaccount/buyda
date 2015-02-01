class ChangeColumnNameOptionIdToProductOptionId < ActiveRecord::Migration
  def change
      rename_column :product_option_values, :option_id, :product_option_id
  end
end
