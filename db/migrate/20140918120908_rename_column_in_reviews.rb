class RenameColumnInReviews < ActiveRecord::Migration
  def change
      rename_column :reviews, :customer_id, :user_id
  end
end
