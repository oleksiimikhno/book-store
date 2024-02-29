class CreateProductsLabels < ActiveRecord::Migration[7.1]
  def up
    create_table :products_labels do |t|
      t.references :product, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :products_labels
  end
end
