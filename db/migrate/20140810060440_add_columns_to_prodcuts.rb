class AddColumnsToProdcuts < ActiveRecord::Migration
  def change
      add_column :products, :in_stock, :string
      add_column :products, :reduce_stock, :boolean
      add_column :products, :require_shipping, :string
      add_column :products, :manufactuering_date, :date
      add_column :products, :active_from, :datetime
      add_column :products, :user_id, :integer
      change_column :products, :description, :text
  end
end
