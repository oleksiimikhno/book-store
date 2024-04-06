class Email::CouponService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
    @coupon = set_coupon
  end

  def call
    Email::SendCouponWorker.perform_async(@coupon.id)
  end

  private

  def set_coupon
    Coupon.find_by(email: params[:email])
  end
end
