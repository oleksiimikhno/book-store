# frozen_string_literal: true
require 'sidekiq-scheduler'

class Email::SubscriptionBestsellerWorker
  include Sidekiq::Worker

  def perform
    users = User.all
    products = Product.bestsellers.first(5)

    users.each do |user|
      SubscriptionMailer.subscription_email(user, products).deliver_now
    end
  end
end
