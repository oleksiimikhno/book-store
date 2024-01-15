# frozen_string_literal: true

module CartItemableController
  extend ActiveSupport::Concern

  def find_or_create_uniq_record(cart_item, params)
    term = cart_item && cart_item.price == @product.price

    if term
      cart_item.update(quantity: cart_item.quantity + 1)
      cart_item.reload
    else
      CartItem.create!(params)
    end
  end
end
