class Email::SubscriptionService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
    @subscription = set_subscription
    @user = set_user
  end

  def call
    if @user
      Subscription.create!(first_name: @user.first_name, email: @user.email)
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
    User.find_by(email: params[:email])
  end
end
