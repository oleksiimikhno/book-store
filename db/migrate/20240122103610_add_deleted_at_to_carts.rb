class AddDeletedAtToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :deleted_at, :datetime
    add_index :carts, :deleted_at
  end

  def down
    remove_index :carts, :deleted_at
    remove_column :carts, :deleted_at
  end
end
