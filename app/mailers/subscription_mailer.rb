class SubscriptionMailer < ApplicationMailer
  before_action :set_url

  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def subscription_email(user, products)
    @user = user
    @products = products

    mail(to: @user.email, subject: 'VartoRead: Our 5 bestsellers books!')
  end

  private

  def set_url
    @url = Rails.env.development? ? 'http://localhost:3000' : default_url_options
  end
end
