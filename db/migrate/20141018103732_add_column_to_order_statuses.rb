class AddColumnToOrderStatuses < ActiveRecord::Migration
  def change
      add_column :order_statuses, :send_email, :boolean, :default => false
  end
end
