class Email::SubscriptionService < ApplicationServices
  attr_reader :params
  before_action :set_subscription, :set_user

  def initialize(params)
    @params = params
  end

  def call
    if @user
      @user.subscription.create!(params)
    else
      Subscription.create!(params)
    end
  end

  private

  def set_subscription
    subscription = Subscription.find_by(email: params[:email])
    raise StandardError, 'Subscription already exist!' if subscription.present?
  end

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
