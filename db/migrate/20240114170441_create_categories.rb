class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :meta_title
      t.text :meta_description

      t.timestamps
    end
  end
end
