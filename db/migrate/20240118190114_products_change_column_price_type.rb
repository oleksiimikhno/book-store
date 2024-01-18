class ProductsChangeColumnPriceType < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :price, :float
  end
end
