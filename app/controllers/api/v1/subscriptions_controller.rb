# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create update]
  before_action :set_subscription, only: %i[show update]
  before_action :pundit_authorize, except: :show

  def show
    render_success(data: @subscription, status: :ok, serializer: Api::V1::SubscriptionSerializer)
  end

  def create
    Email::SubscriptionService(params)
    render_success(data: 'You are subscribe!', status: :ok, serializer: Api::V1::SubscriptionSerializer)
  end

  def update
    Email::SubscriptionUpdateStatusService(params)
    render_success(data: @subscription, status: :ok, serializer: Api::V1::SubscriptionSerializer)
  end

  private

  def set_subscription
    @subscription = Subscription.find_by(email: params[:email])
  end

  def subscription_params
    params.permit(:email, :status)
  end
end
