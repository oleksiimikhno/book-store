class Email::OrderStatusService < ApplicationServices
  attr_reader :cart

  def initialize(cart)
    @order = cart
  end

  def call
    if @order.paid?
      Email::OrderCompletedWorker.perform_async(@order.id)
    else
      Email::OrderChangedStatusWorker.perform_async(@order.id)
    end
  end
end
