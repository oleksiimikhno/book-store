class Coupon < ApplicationRecord
  include Couponable
  DEFAULT_DISCOUNT_PERCENT_VALUE = 10

  belongs_to :user, optional: true
  has_secure_token :token

  enum :status, %i[active inactive], default: :active

  attribute :discount_value, :integer, default: DEFAULT_DISCOUNT_PERCENT_VALUE
end
