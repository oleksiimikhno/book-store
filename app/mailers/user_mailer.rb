class UserMailer < ApplicationMailer
  include Tokenable

  before_action :set_user, :set_url

  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def registration_email
    mail(to: @user.email, subject: 'Thank you for your registration!')
  end

  def reset_password_email
    @token = user_data_with_token(@user)[:token]
    mail(to: @user.email, subject: 'Your link for reset the password!')
  end

  private

  def set_user
    @user = User.find(params[:user][:id])
  end

  def set_url
    @url = Rails.env.development? ? 'http://localhost:3000' : default_url_options
  end
end
