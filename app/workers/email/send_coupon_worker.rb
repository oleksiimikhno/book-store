# frozen_string_literal: true

class Email::SendCouponWorker
  include Sidekiq::Worker

  def perform(coupon_id)
    coupon = Coupon.find(coupon_id)

    CouponMailer.with(coupon: coupon).send_coupon_email.deliver_later if coupon
  end
end
