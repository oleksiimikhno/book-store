# frozen_string_literal: true

class Email::RegistrationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    UserMailer.registration_email(user).deliver_later if user
  end
end
