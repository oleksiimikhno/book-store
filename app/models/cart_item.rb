# frozen_string_literal: true

class CartItem < ApplicationRecord
  include CartItemableModel

  acts_as_paranoid

  belongs_to :cart
  belongs_to :product
end
