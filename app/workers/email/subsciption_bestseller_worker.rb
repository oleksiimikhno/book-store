# frozen_string_literal: true

class Email::SubscriptionBestsellerWorker
  include Sidekiq::Worker

  def perform
    p '_____sss123____'
    # SubscriptionBestsellerService.new(class_name: 'Io').call
  end
end
