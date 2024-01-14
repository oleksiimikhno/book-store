class CartItem < ApplicationRecord
  include CartItemable

  belongs_to :cart
  belongs_to :product
end
