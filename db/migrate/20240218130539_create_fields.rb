class CreateFields < ActiveRecord::Migration[7.1]
  def up
    create_table :fields do |t|
      t.string :value, null: false
      t.references :label, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :fields
  end
end
