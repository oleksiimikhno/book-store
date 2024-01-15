# frozen_string_literal: true

class CartItem < ApplicationRecord
  include CartItemableModel

  belongs_to :cart
  belongs_to :product
end
