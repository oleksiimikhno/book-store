class OrderMailer < ApplicationMailer
  before_action :set_order, :set_user, :set_url
  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def order_completed_email
    mail(to: @user.email, subject: "Thank you for your order ##{@order.id}!")
  end

  def order_changed_status_email
    mail(to: @user.email, subject: "Your order ##{@order.id} status changed to #{@order.status}!")
  end

  private

  def set_order
    @order = params[:order]
  end

  def set_user
    @user = User.find(@order.user_id)
  end

  def set_url
    @url = Rails.env.development? ? 'http://localhost:3000' : default_url_options
  end
end
