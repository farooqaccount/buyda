class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :code
      t.string :locale
      t.string :directory
      t.string :filename
      t.integer :sort_order
      t.string :status
      t.boolean  :is_default

      t.timestamps
    end
  end
end
