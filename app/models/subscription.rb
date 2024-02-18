class Subscription < ApplicationRecord
  include Subscriptionable

  belongs_to :user, optional: true

  enum :status, %i[active inactive], default: :inactive
end
