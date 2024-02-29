class CreateLabels < ActiveRecord::Migration[7.1]
  def up
    create_table :labels do |t|
      t.string :title, null: false

      t.timestamps
    end
  end

  def down
    drop_table :labels
  end
end
