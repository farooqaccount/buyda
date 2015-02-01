class AddColumnsToCategories < ActiveRecord::Migration
  def change
      add_column :categories, :title, :string
      add_column :categories, :description, :text
      add_column :categories, :is_active, :string
      add_column :categories, :meta_title, :text
      add_column :categories, :meta_description, :text
      add_column :categories, :meta_keyword, :text
  end
end
