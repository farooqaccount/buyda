class AddIsDefaultColumnToReturnStatuses < ActiveRecord::Migration
  def change
      add_column :return_statuses, :is_default, :boolean
  end
end
