# frozen_string_literal: true

module CartItemableController
  extend ActiveSupport::Concern

  def find_or_create_uniq_record(params)
    cart_item = CartItem.find_by(cart_id: @cart.id, product_id: @product.id)
    term = cart_item.present? ? (cart_item.price == @product.price) : false

    if term
      cart_item.update(quantity: cart_item.quantity + 1)
      cart_item.reload
    else
      CartItem.create!(params)
    end
  end
end
