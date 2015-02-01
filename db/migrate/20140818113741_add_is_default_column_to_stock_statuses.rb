class AddIsDefaultColumnToStockStatuses < ActiveRecord::Migration
  def change
      add_column :stock_statuses, :is_default, :boolean
  end
end
