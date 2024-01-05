class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :meta_title
      t.text :meta_description
      t.integer :quantity, default: 0
      t.integer :price, default: 0
      t.integer :status

      t.timestamps
    end
  end
end
