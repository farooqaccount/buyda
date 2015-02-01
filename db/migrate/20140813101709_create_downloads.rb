class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
        t.string :name
        t.string :filename
        t.datetime :date_added
        t.string :mask
      t.timestamps
    end
  end
end
