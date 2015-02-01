class ReturnReason < ActiveRecord::Migration
  def change
      create_table :return_reasons do |t|
      t.string :name

      t.timestamps
      end
  end
end
