class AddDeletedAtToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :deleted_at, :datetime
    add_index :categories, :deleted_at
  end

  def down
    remove_index :categories, :deleted_at
    remove_column :categories, :deleted_at
  end
end
