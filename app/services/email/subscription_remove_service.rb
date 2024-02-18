class Email::SubscriptionRemoveService < ApplicationServices
  attr_reader :params
  before_action :set_subscription, :set_token

  def initialize(params)
    @params = params
  end

  def call
    raise StandardError, 'Subscription token incorrect!' unless @token

    @subscription.destroy
  end

  private

  def set_subscription
    @subscription = Subscription.find_by(email: params[:email])
    raise StandardError, 'Subscription email incorrect!' if @subscription.empty?
  end

  def token
    @token = @subscription.unsubscribe_token == params[:token]
  end
end
