# frozen_string_literal: true

class Email::OrderCompletedWorker
  include Sidekiq::Worker

  def perform(cart_id)
    cart = Cart.find(cart_id)

    OrderMailer.with(order: cart).order_completed_email.deliver_later if cart
  end
end
