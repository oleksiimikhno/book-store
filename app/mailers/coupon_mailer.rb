class CouponMailer < ApplicationMailer
  before_action :set_coupon, :set_url

  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def send_coupon_email
    mail(to: @coupon.email, subject: 'VartoRead you the discount coupon!')
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:coupon][:id])
  end

  def set_url
    @url = Rails.env.development? ? 'http://localhost:3000' : default_url_options
  end
end
