class Email::SubscriptionRemoveService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
    @subscription = set_subscription
  end

  def call
    raise StandardError, 'Subscription token incorrect!' if @subscription.nil?

    @subscription.destroy
  end

  private

  def set_subscription
    Subscription.find_by(token: params[:token])
  end
end
