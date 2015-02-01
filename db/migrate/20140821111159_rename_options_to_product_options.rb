class RenameOptionsToProductOptions < ActiveRecord::Migration
  def change
      rename_table :options, :product_options
      rename_table :option_values, :product_option_values
  end
end
