# frozen_string_literal: true

class RegistrationEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)

    Email::RegistrationService.call(user) if user
  end
end
