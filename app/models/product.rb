# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image
  has_many_attached :images

  # TODO move to a validations
  validates :image, content_type: %i[png jpg jpeg webp], size: {
    between: 1.kilobyte..2.megabytes,
    message: 'is not given between size'
  }
# , processable_image: true
  validates :images, content_type: %i[png jpg jpeg webp], size: {
    between: 1.kilobyte..2.megabytes,
    message: 'is not given between size'
  }

  enum :status, %i[active inactive archived], default: :active

  default_scope { order(created_at: :desc) }
  scope :order_by_date, ->(type = :desc) { reorder(created_at: type) if type.present? }
  scope :order_by_price, ->(type = :desc) { reorder(price: type) if type.present? }
end
