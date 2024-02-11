# frozen_string_literal: true

class Email::OrderCompletedWorker
  include Sidekiq::Worker

  def perform(cart_id)
    cart = Cart.find_by(id: cart_id)

    OrderMailer.order_completed_email(cart).deliver_later if cart
  end
end
