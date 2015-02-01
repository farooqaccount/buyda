class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
        t.integer :product_id
        t.integer :customer_id
        t.string :author
        t.text    :description
        t.integer :rating
        t.string :status
        
      t.timestamps
    end
  end
end
