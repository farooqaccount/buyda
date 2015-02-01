class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :title
      t.string :code
      t.string :symbol_left
      t.string :symbol_right
      t.integer :decimal_place
      t.decimal :value
      t.string :status
      t.boolean  :is_default

      t.timestamps
    end
  end
end
