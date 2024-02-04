class Email::RegistrationService < ApplicationServices
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    UserMailer.with(user: @user).registration_email.deliver_later
  end
end
