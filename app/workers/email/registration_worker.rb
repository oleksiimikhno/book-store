# frozen_string_literal: true

class Email::RegistrationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    UserMailer.with(user: user).registration_email.deliver_later if user
  end
end
