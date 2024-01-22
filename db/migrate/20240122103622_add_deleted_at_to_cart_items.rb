class AddDeletedAtToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :deleted_at, :datetime
    add_index :cart_items, :deleted_at
  end

  def down
    remove_index :cart_items, :deleted_at
    remove_column :cart_items, :deleted_at
  end
end
