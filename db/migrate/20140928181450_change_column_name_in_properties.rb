class ChangeColumnNameInProperties < ActiveRecord::Migration
  def change
      rename_column :properties, :state_id, :country_id
      rename_column :properties, :district_id, :zone_id
  end
end
