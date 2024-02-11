class AddColumnToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :name, :string
  end
end
