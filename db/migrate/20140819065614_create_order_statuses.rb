class CreateOrderStatuses < ActiveRecord::Migration
  def change
    drop_table :order_statuses
    create_table :order_statuses do |t|
        t.string   :name
        t.boolean :is_default
      t.timestamps
    end
  end
end
