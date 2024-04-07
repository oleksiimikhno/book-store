# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create destroy]
  before_action :subscription_params, only: :create
  before_action :set_subscription, only: :destroy

  def show
    subscription = current_user.subscription
    authorize subscription

    render_success(data: subscription, status: :ok, serializer: Api::V1::SubscriptionSerializer)
  end

  def create
    subscription = User::SubscriptionService.call(subscription_params)
    render_success(data: subscription, status: :created, serializer: Api::V1::SubscriptionSerializer)
  end

  def destroy
    @subscription.destroy
    render_success(data: { message: 'You are unsubscribe!' }, status: :ok)
  end

  private

  def set_user
    @user = @subscription.user
  end

  def set_subscription
    @subscription = Subscription.find_by(token: params[:token])
    raise StandardError, 'Subscription token incorrect!' if @subscription.nil?
  end

  def subscription_params
    params.permit(:first_name, :email)
  end
end
