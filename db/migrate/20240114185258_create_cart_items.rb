class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 0, null: false
      t.float :price, default: 0, null: false
      t.belongs_to :cart, null: false
      t.belongs_to :product, null: false

      t.timestamps
    end
  end

  def down
    drop_table :cart_items
  end
end
