class AddColumnsSpecialPriceAndModelToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :special_price, :float, default: 0
    add_column :products, :model, :string
  end
end
