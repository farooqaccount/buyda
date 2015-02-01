class ReturnStatus < ActiveRecord::Migration
  def change
      create_table :return_statuses do |t|
      t.string :name

      t.timestamps
      end
  end
end
