class SubscriptionBestsellerService < ApplicationServices
  # def initialize
  #   @subscription = set_subscription
  #   # @user = set_user
  # end

  attr_reader :class_name

  def initialize(class_name)
    @class_name = class_name
  end

  def call
    p "________send_______"
    debugger
  end

  private

  def set_subscription
    p "________send____2___"
    debugger
    # subscription = Subscription.find_by(email: params[:email])
    # raise StandardError, 'Subscription already exist!' if subscription.present?
  end
end
