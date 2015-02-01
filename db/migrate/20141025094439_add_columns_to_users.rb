class AddColumnsToUsers < ActiveRecord::Migration
  def change
      add_column :users, :subscribe_newsletter, :boolean
      add_column :users, :phone_number, :string
  end
end
