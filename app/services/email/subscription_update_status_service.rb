class Email::SubscriptionUpdateStatusService < ApplicationServices
  attr_reader :params
  before_action :set_subscription, :set_token

  def initialize(params)
    @params = params
  end

  def call
    @subscription
  end

  private

  def set_subscription
    @subscription = Subscription.find_by(email: params[:email])
    raise StandardError, 'Subscription email incorrect!' if @subscription.empty?
  end

  def set_token
    raise StandardError, 'Subscription token incorrect!' unless @subscription.unsubscribe_token == params[:token]

    @subscription.update(status: params[:status])
  end
end
