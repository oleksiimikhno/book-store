# frozen_string_literal: true

class Api::V1::SubscriptionsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create destroy]
  # before_action :pundit_authorize, except: :show

  def show
    render_success(data: current_user.subscription, status: :ok, serializer: Api::V1::SubscriptionSerializer)
  end

  def create
    subscription = Email::SubscriptionService.call(params)
    render_success(data: subscription, status: :created, serializer: Api::V1::SubscriptionSerializer)
  end

  def destroy
    Email::SubscriptionRemoveService.call(params)
    render_success(data: { message: 'You are unsubscribe!' }, status: :ok)
  end

  private

  def set_user
    @user = @subscription.user
  end

  def subscription_params
    params.permit(:email)
  end
end
