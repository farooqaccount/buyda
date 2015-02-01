class CreateWeightClasses < ActiveRecord::Migration
  def change
    create_table :weight_classes do |t|
         t.string :title
        t.string :unit
        t.decimal :value, precision: 15, scale: 8
      t.timestamps
    end
  end
end
