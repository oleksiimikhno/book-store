class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.column :status, :integer, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :carts
  end
end
