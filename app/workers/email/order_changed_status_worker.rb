# frozen_string_literal: true

class Email::OrderChangedStatusWorker
  include Sidekiq::Worker

  def perform(cart_id)
    cart = Cart.find_by(id: cart_id)

    OrderMailer.with(cart: cart).order_changed_status_email.deliver_later if cart
  end
end
