# frozen_string_literal: true

class Api::V1::CouponsController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :coupons_params, only: :create
  before_action :set_coupon, only: :show

  def show
    raise StandardError, 'Coupon unexist!' if @coupon.nil?

    render_success(data: @coupon, status: :ok, serializer: Api::V1::CouponSerializer)
  end

  def create
    coupon = User::CouponService.call(coupons_params)
    Email::CouponService.call(coupon)
    render_success(data: coupon, status: :created)
  end

  private

  def set_coupon
    @coupon = current_user.coupon 
  end

  def coupons_params
    params.permit(:first_name, :email)
  end
end
