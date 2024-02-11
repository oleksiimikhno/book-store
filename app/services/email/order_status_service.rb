class Email::OrderStatusService < ApplicationServices
  attr_reader :cart

  def initialize(cart)
    @order = cart
  end

  def call
    if @order.paid?
      Email::OrderCompletedWorker.perform_async(cart.id)
    else
      Email::OrderChangedStatusWorker.perform_async(cart.id)
    end
  end
end
