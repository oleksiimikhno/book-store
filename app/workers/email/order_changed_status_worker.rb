# frozen_string_literal: true

class Email::OrderChangedStatusWorker
  include Sidekiq::Worker

  def perform(cart_id)
    cart = Cart.find(cart_id)

    OrderMailer.with(order: cart).order_changed_status_email.deliver_later if cart
  end
end
