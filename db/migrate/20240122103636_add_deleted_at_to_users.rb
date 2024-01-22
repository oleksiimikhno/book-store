class AddDeletedAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
  end

  def down
    remove_index :users, :deleted_at
    remove_column :users, :deleted_at
  end
end
