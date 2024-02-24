# frozen_string_literal: true

class Email::ResetPasswordWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    UserMailer.with(user: user).reset_password_email.deliver_later if user
  end
end
