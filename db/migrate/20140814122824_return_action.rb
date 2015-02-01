class ReturnAction < ActiveRecord::Migration
  def change
      create_table :return_actions do |t|
      t.string :name

      t.timestamps
      end
  end
end
