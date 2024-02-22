class AddColumnsDiscountAndModelToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :discount, :integer, default: 0
    add_column :products, :model, :string
  end
end
