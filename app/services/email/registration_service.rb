class Email::RegistrationService < ApplicationServices
  attr_reader :user

  def initialize(user)
    @user = user
    @host = 'request.host'
  end

  def call
    UserMailer.with(user: @user, host: @host).registration_email.deliver_later
  end
end
