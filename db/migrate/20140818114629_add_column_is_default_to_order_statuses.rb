class AddColumnIsDefaultToOrderStatuses < ActiveRecord::Migration
  def change
      add_column :order_statuses, :is_default, :boolean
  end
end
