class OrderMailer < ApplicationMailer
  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def order_completed_email(order = '')
    @order = params[:order] || order
    @user = @order.user
    @url = Rails.env.development? ? 'http://localhost:3000' : default_url_options

    mail(to: @user.email, subject: 'Thank you for your registration!')
  end
end
