class User::CouponService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
    @user = set_user
  end

  def call
    raise StandardError, 'User already has paid cart!' if user_has_paid_cart?
    raise StandardError, 'User already has coupon!' if user_has_coupon?

    if @user
      Coupon.create!(user_id: @user.id, **params)
    else
      Coupon.create!(params)
    end
  end

  private

  def set_user
    User.find_by(email: params[:email])
  end

  def user_has_paid_cart?
    @user.carts.find_by(status: 'paid').present?
  end

  def user_has_coupon?
    Coupon.find_by(email: params[:email]).present?
  end
end
