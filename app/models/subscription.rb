class Subscription < ApplicationRecord
  include Subscriptionable

  belongs_to :user, optional: true
  has_secure_token :unsubscription_token

  enum :status, %i[active inactive], default: :inactive
end
